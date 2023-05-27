const { db } = require("../util/admin");

exports.rooms = async (req, res) => {
    const roomsRef = db.collection('rooms');
    try{
            roomsRef.get().then((snapshot) => {
            const data = snapshot.docs.map((doc) => ({
            id: doc.id,
            ...doc.data(),
        }));
            console.log(data);
            return res.status(201).json(data);
        })
    } catch (error) {
        return res
        .status(500)
        .json({ general: "Something went wrong, please try again"});          
    }
};
