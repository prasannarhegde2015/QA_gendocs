import { test } from  '@playwright/test'

test.beforeEach( async({page}) => {
    await page.goto("http://localhost:4200/");
    await page.getByText("Forms").click();
    await page.getByText("Form Layouts").click();
})

test('firstDemoTest', async ({page}) => {
  
});


test('datepickertest', async ({page}) => {
    await page.getByText("Datepicker").click();
});


test("UserFacingLocators", async({page} ) => {

     await page.getByRole("textbox",{name:"Email"} ).first().click()
})

test("ChildElements", async({page} ) => {

    await page.locator("nb-card-body nb-radio :text-is('Option 1')").click()
    var gridheader = page.locator('nb-card-header').filter({ hasText : "Using the Grid"})
    await page.locator('nb-card',{has: gridheader}).getByRole("button",{name:"Sign In"}).click()
})

