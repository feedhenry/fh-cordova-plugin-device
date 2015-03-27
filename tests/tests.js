/*
 * JBoss, Home of Professional Open Source.
 * Copyright Red Hat, Inc., and individual contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

exports.defineAutoTests = function () {
  var deviceType = (navigator.userAgent.match(/Android/i)) == "Android" ? "Android" : null;
  describe('fhdevice object', function () {
    it("should exist", function () {
      expect(fhdevice).toBeDefined();
    });

    if (deviceType == 'Android') {
      it("should contain a density that is a string", function () {
        expect(fhdevice.density).toBeDefined();
        expect((new String(fhdevice.density)).length > 0).toBe(true);
      });
    } else {
      it("should contain a UUID specification that is a string", function () {
        expect(fhdevice.uuid).toBeDefined();
        expect(new String(fhdevice.density).length > 0).toBe(true);
      });
      it("should contain a cuidMap that is a Array", function () {
        expect(fhdevice.cuidMap).toBeDefined();
        expect(fhdevice.cuidMap.constructor === Array);
        expect(fhdevice.cuidMap.length > 0).toBe(true);
      });
    }
  });
};

exports.defineManualTests = function(contentEl, createActionButton) {
  var logMessage = function (message, color) {
        var log = document.getElementById('info');
        var logLine = document.createElement('div');
        if (color) {
            logLine.style.color = color;
        }
        logLine.innerHTML = message;
        log.appendChild(logLine);
    }

    var clearLog = function () {
        var log = document.getElementById('info');
        log.innerHTML = '';
    }

    var device_tests = '<h3>Press Dump Device button to get device uuid or density</h3>' +
        '<div id="dump_device"></div>' +
        'Expected result: Status box will get updated with device info. (i.e. cuid, uuid, density)';

    contentEl.innerHTML = '<div id="info"></div>' + device_tests;

    createActionButton('Dump device', function() {
      clearLog();
      logMessage(JSON.stringify(fhdevice, null, '\t'));
    }, "dump_device");
};