var express = require('express');
var bcrypt = require('bcrypt');
var moment = require('moment');
var userModel = require('../models/user.model');
var passport = require('passport');
var auth = require('../middlewares/auth');

var router = express.Router();

router.get('/register', (req, res, next) => {
  res.render('vwAccount/register');
})

router.post('/register', (req, res, next) => {
  try{
    var saltRounds = 10;
  var hash = bcrypt.hashSync(req.body.exampleInputPassword1, saltRounds);
  var dob = moment(req.body.dob, 'DD/MM/YYYY').format('YYYY-MM-DD');

  var entity = {
    Username: req.body.exampleInputUserName1,
    Email: req.body.exampleInputEmail1,
    Pass: hash,
    DOB:dob,
    Phone:req.body.phone,
    Status_account:0,
    Type_account:0,
    Vip: 0
   }
   console.log(entity);
  userModel.add(entity).then(id => {
    res.redirect('/account/login');
  })
  }catch(error){
    next(error);
  }
})

router.get('/is-available', (req, res, next) => {
  var user = req.query.exampleInputUserName1;
  userModel.singleByUserName(user).then(rows => {
    console.log(rows.length);
    if (rows.length > 0)
      {
        
        return res.json(false);
      }

    return res.json(true);
  });
})
router.get('/is-password', (req, res, next) => {
  var id = req.user.IDAccount;
  var yourPassword=req.query.current;
  userModel.checkyourPassword(id).then(rows => {
    console.log(rows.length);
    var user = rows[0];
    console.log(yourPassword);
    console.log(user);
      var ret = bcrypt.compareSync(yourPassword, user.Pass);
    if (ret)
      {
        
        return res.json(true);
      }

    return res.json(false);
  });
  
})
router.get('/is-availablesameusername', (req, res, next) => {
  var user = req.query.username;
  userModel.singleSameAsUserName(user,req.user.IDAccount).then(rows => {
    console.log(rows.length);
    if (rows.length > 0)
      {
        
        return res.json(false);
      }

    return res.json(true);
  });
})
router.get('/login', (req, res, next) => {
  res.render('vwAccount/login', { layout: false });
})

router.post('/login', (req, res, next) => {
  passport.authenticate('local', (err, user, info) => {
    if (err)
      return next(err);

    if (!user) {
      return res.render('vwAccount/login', {
        layout: false,
        err_message: info.message
      })
    }

    req.logIn(user, err => {
      if (err)
        return next(err);

      return res.redirect('/');
    });
  })(req, res, next);
})

router.post('/logout', auth,(req, res, next) => {
req.logOut();
res.redirect('/account/login');
})

router.get('/profile', (req, res, next) => {
  if(req.isAuthenticated()){
    var id=req.user.IDAccount;
    console.log(id);
    
    userModel.single(id).then(rows => {
      if (rows.length > 0) {
       
        res.render('vwAccount/EditProfile', {
          error: false,
          inforUser: rows[0]
          
        });
      } else {
         
        res.render('vwAccount/EditProfile', { error: true });
      }
    }).catch(err => {
      console.log(err);
    });

}
else{
  res.redirect('/account/login');
}

router.post('/profile', (req, res, next) => {
  try{
  var entity = {
    IDAccount:req.user.IDAccount,
    Email: req.body.email,
    Phone:req.body.phone,
   }
   console.log(entity);
  userModel.update(entity).then(id => {
    res.redirect('/account/profile');
  })
  }catch(error){
    next(error);
  }
})

  
})
router.get('/changePassword', (req, res, next) => {
  if(req.isAuthenticated()){
    res.render('vwAccount/changePassword');    

  }
  else{
    res.redirect('/account/login');
  }
  
})
router.post('/changePassword', (req, res, next) => {
  try{
    var saltRounds = 10;
  var hash = bcrypt.hashSync(req.body.new, saltRounds);

  var entity = {
    IDAccount:req.user.IDAccount,
    Pass: hash
   }
   console.log(entity);
   userModel.update(entity).then(id => {
    res.redirect('/account/login');
  })
  }catch(error){
    next(error);
  }
})
router.get('/submitPost', (req, res, next) => {
  res.render('/writer/submitPost');
})
module.exports = router;