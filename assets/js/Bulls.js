import '../css/App.css';
import "milligram";
//import { generateNum } from './game';
import React, { useState, useEffect } from 'react';
import { ch_display, ch_join, ch_push, ch_restart } from './socket';

function Bulls() {
  const [state, setState] = useState({
    input: "",
    result: [],
    guesses: [],
    alert: "",
  });

  let { input, goal, result, guesses, alert } = state;

  // const [input, setInput] = useState("");
  // const [goal, setGoal] = useState(generateNum());
  // const [result, setResult] = useState([]);
  // const [guesses, setGuesses] = useState([]);
  // const [alert, setAlert] = useState("");

  useEffect(() => {
    ch_join(setState);
  })

  function updateInput(ev) {
    console.log(state.input);
    let num = ev.target.value;

    ch_display(num);
  }

  //console.log(goal);

  function checkGuess() {
    ch_push(state.input)
  }

  function checkEnter(ev) {
    if (ev.key === "Enter") {
      ch_push(state.input);
    }
  }

  function restartGame() {
    ch_restart();
  }

  function OutputTable() {
    let rows = [];

    for (let i = 1; i < 9; i++) {
      rows.push(
        <tr>
          <td>
            {i}
          </td>
          <td>
            {state.guesses[i - 1]}
          </td>
          <td>
            {state.result[i - 1]}
          </td>
        </tr>
      )
    }

    return rows;
  }

  return (
    <div className="App">
      <header>
        4Digits
      </header>
      <div>Input:</div>
      <input id="input" type="text" value={state.input} onChange={updateInput} onKeyPress={checkEnter}></input>
      <button className="button" onClick={ checkGuess }>Guess</button>
      <button onClick={restartGame}>Restart</button>
      <table>
        <tr>
          <th>Try</th>
          <th>Guess</th>
          <th>Result</th>
        </tr>
        <OutputTable></OutputTable>
      </table>
      <div>{state.alert}</div>
    </div>
  );
}

export default Bulls;