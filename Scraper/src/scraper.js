const cheerio = require('cheerio');
const request = require('request-promise');
const fs = require('fs');

const YEAR = 2020;
const MONTHS = {
  Jan: '01',
  Feb: '02',
  Mar: '03',
  Apr: '04',
  May: '05',
  Jun: '06',
  Jul: '07',
  Aug: '08',
  Sep: '09',
  Oct: '10',
  Nov: '11',
  Dec: '12',
};

const SESSIONS = [
  {
    name: 'race',
    locator: '.race'
  },
  {
    name: 'quali',
    locator: '.qualifying',
  },
  {
    name: 'fp3',
    locator: '.free-practice-3'
  },
  {
    name: 'fp2',
    locator: '.free-practice-2',
  },
  {
    name: 'fp1',
    locator: '.free-practice-1'
  }  
];

const getMonthIndex = month => MONTHS[month];

const getName = ($, element) => {
  let name = $(element).find('.event-column').text();
  return name.replace('NEXT', '').replace('TBC', '');
}

const getDate = ($, element) => {
  let date = $(element).find('.date-column').text();
  let [day, month] = date.split(' ');
  month = getMonthIndex(month);
  day = day.padStart(2, '0');
  return `${YEAR}-${month}-${day}`;
}

const getTime = ($, element) => {
  const time = $(element).find('.time-column').text();
  return `${time}:00Z`
}

const getRaces = async () => {
  try { 
    const response = await request.get('https://www.f1calendar.com/');
    const $ = cheerio.load(response);

    const races = [];
    $('tbody').each((index, element) => {
      const event = {};

      // round needs to be first for rainmeter to update the name properly
      event._round = `${index + 1}`;
      event.name = getName($, $(element).find('.race'));
      
      SESSIONS.forEach(session => {
        const elm = $(element).find(session.locator);
        Object.assign(event, { [session.name]: { date: getDate($, elm), time: getTime($, elm) } });
      });

      races.push(event);
    });
    return races;
  } catch (error) {
    console.log(error);
    return undefined;
  }
}

const main = async () => {
  const races = await getRaces();

  if (races) {
    fs.writeFileSync('races.json', JSON.stringify(races));
  }
};

main();