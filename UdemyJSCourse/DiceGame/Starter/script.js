'use strict';
// Add Envet Lister To Roll a Dice

const btnDiceElem = document.querySelector('.btn--roll');
const btnHold = document.querySelector('.btn--hold');
const btnNewGame = document.querySelector('.btn--new');
const imgDiceElem = document.querySelector('.dice');
const player1section = document.querySelector('.player--0');
const player2section = document.querySelector('.player--1');
const res1section = document.querySelector('#res--0');
const res2section = document.querySelector('#res--1');
const txtcurrentp1 = document.querySelector('#current--0');
const txtcurrentp2 = document.querySelector('#current--1');
const txtTotalp1 = document.querySelector('#score--0');
const txtTotalp2 = document.querySelector('#score--1');
let scores, currentScore, curPlayer, playover, attempts, att;

const initplay = function () {
  playover = false;
  currentScore = 0;
  scores = [0, 0];
  attempts = [0, 0];
  att = 0;
  txtcurrentp1.textContent = 0;
  txtcurrentp2.textContent = 0;
  txtTotalp1.textContent = 0;
  txtTotalp2.textContent = 0;
  res1section.textContent = '';
  res2section.textContent = '';
  player1section.classList.add('player--active');
  player2section.classList.remove('player--active');
  curPlayer = 0;
  player1section.classList.remove('player--winner');
  player2section.classList.remove('player--winner');
  document.querySelector(`#attempt--0`).textContent = '';
  document.querySelector(`#attempt--1`).textContent = '';
  imgDiceElem.classList.add('hidden');
};
const updateImageByNumber = function (rolledNumber) {
  imgDiceElem.setAttribute('src', `dice-${rolledNumber}.png`);
};

const makePlayerInActive = function (cplayer) {
  let plyersection = cplayer == 1 ? player1section : player2section;
  let othplyersection = cplayer == 1 ? player2section : player1section;
  plyersection.classList.toggle('player--active');
  othplyersection.classList.toggle('player--active');
  // imgDiceElem.classList.add('hidden');
};

const announceWinner = function (cplayer, currentScore) {
  playover = currentScore + scores[cplayer] >= 100;
  if (playover) {
    updateTotal(cplayer, currentScore);
    document.querySelector(`#res--${cplayer}`).innerHTML = ' Winner';
    document
      .querySelector(`.player--${cplayer}`)
      .classList.add('player--winner');
  }
};

const updateTotal = function (player, score) {
  scores[player] += score;
  document.querySelector(`#score--${player}`).textContent = scores[player];
};

const rollDice = function () {
  // 1. If Play Was Over Dont perform furthur steps ahead....
  if (playover) {
    return;
  }
  // 2. Genreate Random number from 1 to 6 for Dice ....
  let randomNum = Math.trunc(Math.random() * 6) + 1;
  updateImageByNumber(randomNum);
  imgDiceElem.classList.remove('hidden');
  if (randomNum != 1) {
    currentScore += randomNum;
    if (currentScore + scores[curPlayer] > 0) {
      announceWinner(curPlayer, currentScore);
    }
  } else {
    currentScore = 0;
    holdAction();
  }
  document.querySelector(`#current--${curPlayer}`).textContent = currentScore;
};

const swapPlayer = function () {
  if (!playover) {
    announceWinner(curPlayer, currentScore);
  }
  // imgDiceElem.classList.add('hidden');
  if (playover) {
    return;
  }
  // Reset the Player Currnet sCore   to zero
  holdAction();
};

const holdAction = function () {
  updateTotal(curPlayer, currentScore);
  document.querySelector(`#current--${curPlayer}`).textContent = 0;
  att++;
  attempts[curPlayer] += att;
  document.querySelector(`#attempt--${curPlayer}`).textContent =
    'Attempt : ' + attempts[curPlayer];
  currentScore = 0;
  makePlayerInActive(curPlayer);
  curPlayer = curPlayer == 0 ? 1 : 0;
  att = 0;
};

initplay();
btnNewGame.addEventListener('click', initplay);
btnDiceElem.addEventListener('click', rollDice);
btnHold.addEventListener('click', swapPlayer);
