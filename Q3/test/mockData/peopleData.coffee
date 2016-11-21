people = -> [
  {id: '1', name: 'Bill Gates', org: 'Microsoft'},
]

interests = -> [
  {personId: '1', name: 'Skiing'},
  {personId: '1', name: 'Philanthropy'},
]

skills = -> [
  {personId: '1', name: 'C++'},
  {personId: '1', name: 'Basic'},
  {personId: '1', name: 'Monopoly'},
]

richest = -> {richestPerson: 1}

module.exports = {people, interests, skills, richest}
