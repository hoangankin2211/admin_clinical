const express = require('express');
const User = require('../models/user');
const bcrypt = require("bcryptjs");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const { json } = require('express');
const auth = require("../middlewares/auth_data");

authRouter.post('/api/signup', async(req, res) => {
    try {
        const { name, email, password } = req.body;
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "User with the same already exisits" });
        }
        const hashedPassword = await bcrypt.hash(password, 8);
        let user = new User({
            email,
            password: hashedPassword,
            name,
        });
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ err: e.message });
    }
});

authRouter.post('/api/signin', async(req, res) => {
    try {
        const { email, password } = req.body;
        console.log("hahahah");
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: "User is not found" });
        }
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect Pssword" });
        }
        const token = jwt.sign({ id: user._id }, "passwordkey");
        res.json({ token, ...user._doc });
    } catch (e) {
        res.status(500).json({ err: e.message });
    }
});

authRouter.post('/api/validToken', async(req, res) => {
    try {
        const token = req.header('x-auth-token');
        if (!token) return res.json({ check: false });
        const verified = jwt.verify(token, "passwordkey");
        if (!verified) return res.json({ check: false });

        const user = await User.findById(verified.id);
        if (!user) return res.json(false);
        // res.json(true);
        res.json({ check: true, ...user._doc });
    } catch (e) {
        res.status(500).json({ err: e.message });
    }
});

authRouter.get('/getUser', auth, async(req, res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token });
});

module.exports = authRouter;