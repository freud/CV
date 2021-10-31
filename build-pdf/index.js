const puppeteer = require('puppeteer')
const fs = require('fs');

async function printPDF(url) {
  const browser = await puppeteer.launch({ headless: true,args: [
    "--disable-gpu",
    "--disable-dev-shm-usage",
    "--disable-setuid-sandbox",
    "--no-sandbox",
] });
  const page = await browser.newPage();
  await page.goto(url, {waitUntil: 'networkidle0'});
  const pdf = await page.pdf({ path: 'resume.pdf', format: 'A4',
    margin: {
        top: "2cm",
        right: "1.5cm",
        bottom: "2cm",
        left: "1.5cm"
    },
    printBackground: true }
);
  await browser.close();
  return pdf
};

const process = require( 'process' );

const argv = key => {
  if ( process.argv.includes( `--${ key }` ) ) return true;
  const value = process.argv.find( element => element.startsWith( `--${ key }=` ) );
  if ( !value ) return null;
  return value.replace( `--${ key }=` , '' );
}

var url = argv('url') || 'https://sroczynski.cloud'
printPDF(url);