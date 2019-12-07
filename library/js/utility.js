/**
 * Javascript utility functions for openemr
 *
 * @package   OpenEMR
 * @link      http://www.open-emr.org
 * @author    Brady Miller <brady.g.miller@gmail.com>
 * @author    Jerry Padgett <sjpadgett@gmail.com>
 * @copyright Copyright (c) 2019 Brady Miller <brady.g.miller@gmail.com>
 * @copyright Copyright (c) 2019 Jerry Padgett <sjpadgett@gmail.com>
 * @license   https://github.com/openemr/openemr/blob/master/LICENSE GNU General Public License 3
 */
/* We should really try to keep this library jQuery free ie javaScript only! */

// Translation function
// This calls the i18next.t function that has been set up in main.php
function xl(string) {
    if (typeof top.i18next.t == 'function') {
        return top.i18next.t(string);
    } else {
        // Unable to find the i18next.t function, so log error
        console.log("xl function is unable to translate since can not find the i18next.t function");
        return string;
    }
}

/*
* function includeDependency(url, async)
*
* @summary Dynamically include JS Scripts or Css.
*
* @param {string} url file location.
* @param {boolean} async true/false load asynchronous/synchronous.
* @param {string} 'script' | 'link'.
*
* */
function includeDependency(url, async, type) {
    try {
        let request = new XMLHttpRequest();
        if (type === "link") {
            let headElement = document.getElementsByTagName("head")[0];
            let newScriptElement = document.createElement("link")
            newScriptElement.type = "text/css";
            newScriptElement.rel = "stylesheet";
            newScriptElement.href = url;
            headElement.appendChild(newScriptElement);
            console.log('Needed to load:[ ' + url + ' ] For: [ ' + location + ' ]');
            return false;
        }
        request.open("GET", url, async); // false = synchronous.
        request.send(null);
        if (request.status === 200) {
            if (type === "script") {
                let headElement = document.getElementsByTagName("head")[0];
                let newScriptElement = document.createElement("script");
                newScriptElement.type = "text/javascript";
                newScriptElement.text = request.responseText;
                headElement.appendChild(newScriptElement);
                console.log('Needed to load:[ ' + url + ' ] For: [ ' + location + ' ]');
                return false; // in case req comes from a submit form.
            }
        }
        new Error("Failed to get URL:" + url);
    } catch (e) {
        throw e;
    }
}

/*
*  This is where we want to decide what we need for the instance
*  We only want to load any needed dependencies.
*
*/
document.addEventListener('DOMContentLoaded', function () {
    let isNeeded = document.querySelectorAll('.drag-resize').length;
    if (isNeeded) {
        initDragResize(".drag-resize");
    }

}, false);

/*
* function initDragResize(interactors = '.drag-resize', context = document)
* @summary call this function from scripts you may want to provide a different
*  context other than the page context of this utility
*
* @param {string} selector of element to apply drag.
* @param {object} optional context of element. document is default.
*/
function initDragResize(interactors = '.drag-resize', context = document) {
    let isLoaded = typeof window.interact;
    if (isLoaded !== 'function') {
        let load = async () => {
            let interactfn = top.webroot_url + '/public/assets/interactjs/dist/interact.js';
            await includeScript(interactfn, false, 'script');
        };
        load().then(rtn => {
            initInteractors(".drag-resize", context);
        });
    }
}

/* function to init all page drag elements.*/
function initInteractors(interactors = '.drag-resize', context = document) {
    interact(interactors, {context: context}).draggable({
        inertia: true,
        restrict: {
            //restriction: "parent",
            endOnly: true,
            elementRect: {top: 1, left: 1, bottom: 1, right: 1}
        },
        snap: {
            targets: [interact.createSnapGrid({x: 1, y: 1})],
            range: Infinity,
            relativePoints: [{x: 0, y: 0}]
        },
        autoScroll: true,
        maxPerElement: 2
    }).on('dragstart', function (event) {
        event.preventDefault();
    }).on('dragmove', dragMoveListener).resizable({
        preserveAspectRatio: false,
        edges: {
            //left: '.resize-handle',
            right: true,
            bottom: true,
            top: '.resize-handle'
        }
    }).on('resizestart', function (event) {
        //console.info('resizestart = ', event);
    }).on('resizemove', function (event) {
        //console.info('resizemove = ', event);
        let target = event.target;
        let x = (parseFloat(target.getAttribute('data-x')) || 0);
        let y = (parseFloat(target.getAttribute('data-y')) || 0);

        target.style.width = event.rect.width + 'px';
        target.style.height = event.rect.height + 'px';
        x += event.deltaRect.left;
        y += event.deltaRect.top;

        target.style.webkitTransform = target.style.transform = 'translate(' + x + 'px,' + y + 'px)';
        target.setAttribute('data-x', x);
        target.setAttribute('data-y', y);
    });

    function dragMoveListener(event) {
        let target = event.target;
        let x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx;
        let y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy;

        if ('webkitTransform' in target.style || 'transform' in target.style) {
            target.style.webkitTransform =
                target.style.transform =
                    'translate(' + x + 'px, ' + y + 'px)';
        } else {
            target.style.left = x + 'px';
            target.style.top = y + 'px';
        }

        target.setAttribute('data-x', x);
        target.setAttribute('data-y', y);
    }
}
