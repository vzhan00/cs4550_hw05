export function generateNum() {
  let set = new Set([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
  let new_goal = [];
  while (new_goal.length < 4) {
    let index = Math.floor(Math.random() * set.size);
    let element = Array.from(set)[index];
    new_goal.push(element);
    set.delete(element);
  }

  return new_goal;
}

