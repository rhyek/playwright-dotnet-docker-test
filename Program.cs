// See https://aka.ms/new-console-template for more information

using Microsoft.Playwright;

Console.WriteLine("Hello, World!");
using var playwright = await Playwright.CreateAsync();
await using var browser = await playwright.Chromium.LaunchAsync(new() { Headless = true });
var page = await browser.NewPageAsync();
await page.GotoAsync("https://wikipedia.org");
var slogan = await page.QuerySelectorAsync(".localized-slogan");
Console.WriteLine("slogan: {0}", await slogan!.TextContentAsync());
