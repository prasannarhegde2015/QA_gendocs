var support = require('../support');
var chai = require('C:/Users/SONY/AppData/Roaming/npm/node_modules/chai');
var chaiAsPromised = require('C:/Users/SONY/AppData/Roaming/npm/node_modules/chai-as-promised');
chai.use(chaiAsPromised);

var expect = chai.expect;
var steps = function() {

  this.Given(/^I am on the homepage$/, function(callback) {
    browser.driver.ignoreSynchronization = true ;
    browser.driver.get('http://localhost');
    callback();
//  setTimeout(callback, 10000);
  });

  this.Then(/^I should see a "([^"]*)"$/, function(link1) {
    var lnktext = "";
    browser.driver.ignoreSynchronization = true ;
    browser.driver.wait(function() {
     return browser.driver.findElement(by.xpath('//a[text()="PHP Samples"]'))
              .then(function(elem) {
            //    elem.click();
                elem.getText().then(function(text){ console.log("Non Angular Text22: "+text);expect(text).to.equal('PHP Samples');});
                console.log("Non Angular Text: "+lnktext);
                return true;
              });
  }, 15000);
  //  browser.pause();
     console.log("Non Angular Text: "+lnktext);
  //   expect(lnktext).to.equal(link1);
  });

  this.When(/^I click on "([^"]*)"$/, function(link1,callback) {
    var lnktext = "";
    browser.driver.ignoreSynchronization = true ;
    browser.driver.wait(function() {
     return browser.driver.findElement(by.xpath('//a[text()="PHP Samples"]'))
              .then(function(elem) {
                elem.click();
                return true;
              });
  }, 15000);
         callback();
    });

  this.Then(/^I should find "([^"]*)"$/, function(link2,callback) {
    var lnktext = "";
    browser.driver.ignoreSynchronization = true ;
    browser.driver.wait(function() {
     return browser.driver.findElement(by.xpath('//a[contains(text(),"Create Web List")]'))
              .then(function(elem) {
          //     elem.click();
                elem.getText().then(function(text){ console.log("text last step : 2:  "+text);expect(text).to.contain('Create Web List.'); });
          //      expect(lnktext).to.equal('Create Web List.');
                return true;
              });
  }, 15000);
             callback();
  });

};

module.exports = steps;
