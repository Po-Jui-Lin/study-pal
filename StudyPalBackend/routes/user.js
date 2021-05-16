const express = require('express');
const bcrypt = require('bcryptjs');
const router = express.Router();
const {db} = require('../init.js');

router.get('/:id', async function(req,res) {
  let user = await db.collection('users').doc(req.params.id).get();
  if (!user.exists) {
    return res.status(404).json({message: "User Not Found!"});
  }
  user = user.data();
  delete user.password;
  res.status(200).json(user);
});

router.post('/', async function(req,res) {
  try{
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(req.body.password, salt);
    let user = {
      name: req.body.name,
      password: hashedPassword,
      todoList: [],
      todoListCategory: null,
      gender: req.body.gender,
      age: req.body.age,
      rating: null,
      usersLiked: [],
      likedBy: [],
      isTodayMatched: false
    };
    const savedUser = await db.collection('users').add(user);
    console.log('Added user with ID: ', savedUser.id);
    delete user.password;
    user.id = savedUser.id;
    res.status(200).json(user);
  }catch(err){
    console.log(err);
    res.status(500).json({message: "Server Error!"});
  }
});

router.patch('/:id', async function(req,res) {
  try{
    let user = {
      name: req.body.name,
      todoList: req.body.todoList,
      todoListCategory: req.body.todoListCategory,
      gender: req.body.gender,
      age: req.body.age
    };
    const savedUser = await db.collection('users').doc(req.params.id).update(user);
    console.log('Updated user with ID: ', savedUser.id);
    let updatedUser = await db.collection('users').doc(req.params.id).get();
    updatedUser = updatedUser.data();
    delete updatedUser.password;
    res.status(200).json(updatedUser);
  }catch(err){
    console.log(err);
    res.status(500).json({message: "Server Error!"});
  }
});


module.exports = router;
