const express = require('express');
const bcrypt = require('bcryptjs');
const router = express.Router();
const {db} = require('../init.js');
const {admin} = require('../init.js');

router.get('/:id', async function(req,res) {
  let user = await db.collection('users').doc(req.params.id).get();
  if (!user.exists) {
    return res.status(404).json({message: "User Not Found!"});
  }
  user = user.data();
  res.status(200).json(user);
});

/*router.get('/:id/todoList', async function(req,res) {
  let user = db.collection('users').doc(req.params.id);
  todoList = await user.collection('todoList').doc().get();
  todoList = await todoList.data();
  res.status(200).json(todoList);
});*/

/*router.get('/', async function(req,res) {
  let allUsers = await db.collection('users').get();
  allUsers.forEach(doc => {
  console.log(await db.collection('users/'+doc.id+'/todoList').get());
  });
  res.status(200).json(allUsers);
});*/

router.post('/', async function(req,res) {
  try{
    let user = {
      usersLiked: [],
      likedBy: [],
      todayMatchedWith: null,
      uid: req.body.uid
    };
    const savedUser = await db.collection('users').doc(req.body.uid).set(user);
    res.status(200).json(user);
  }catch(err){
    console.log(err);
    res.status(500).json({message: "Server Error!"});
  }
});

router.post('/:id/todoList', async function(req,res) {
  try{
    let todo = {
      description: req.body.description,
      isDone: false,
      title: req.body.title
    };
    let user = db.collection('users').doc(req.params.id);
    const savedTodoList = await user.collection('todoList').add(todo);
    res.status(200).json(todo);
  }catch(err){
    console.log(err);
    res.status(500).json({message: "Server Error!"});
  }
});

router.patch('/:id', async function(req,res) {
  try{
    let user = {
      gender: req.body.gender,
      age: req.body.age,
      rating: null,
      usersLiked: [],
      likedBy: [],
      todayMatchedWith: null
    };
    const savedUser = await db.collection('users').doc(req.params.id).update(user);
    let updatedUser = await db.collection('users').doc(req.params.id).get();
    updatedUser = updatedUser.data();
    delete updatedUser.password;
    res.status(200).json(updatedUser);
  }catch(err){
    console.log(err);
    res.status(500).json({message: "Server Error!"});
  }
});

router.put('/:id/usersLiked', async function(req,res) {
  try{
    let user = {
      usersLiked: admin.firestore.FieldValue.arrayUnion(req.body.usersLikedId)
    };
    let userLiked = {
      likedBy: admin.firestore.FieldValue.arrayUnion(req.params.id)
    }
    let savedUserLiked = await db.collection('users').doc(req.body.usersLikedId).update(userLiked);
    const savedUser = await db.collection('users').doc(req.params.id).update(user);
    let updatedUser = await db.collection('users').doc(req.params.id).get();
    updatedUser = updatedUser.data();
    res.status(200).json(updatedUser);
  }catch(err){
    console.log(err);
    res.status(500).json({message: "Server Error!"});
  }
});

router.put('/:id/todayMatchedWith', async function(req,res) {
  try{
    let userLiked = await db.collection('users').doc(req.body.usersLikedId).get();
    userLiked = userLiked.data();
    if (userLiked.usersLiked.indexOf(req.params.id) !== -1 && userLiked.todayMatchedWith == null){
      await db.collection('users').doc(req.body.usersLikedId).update({todayMatchedWith: req.params.id});
      let user = {
        todayMatchedWith: req.body.usersLikedId
      };
      const savedUser = await db.collection('users').doc(req.params.id).update(user);
      let updatedUser = await db.collection('users').doc(req.params.id).get();
      updatedUser = updatedUser.data();
      delete updatedUser.password;
      res.status(200).json(updatedUser);
    }
    else{
      res.status(200).json({message: "Not matched"});
    }
  }catch(err){
    console.log(err);
    res.status(500).json({message: "Server Error!"});
  }
});
module.exports = router;
