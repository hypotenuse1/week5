const express = require('express');
const { runQuery } = require('./database');

const port = 3000;
const app = express();


app.get('/fare', async(req, res, next) => { 
    try{
        const { uid } = req.query;
        const sql = 'select users.name, sum(round(fare_rate*distance/100,-2) as totalFare '+
                    'from tickets inner join users on tickets.user =users.id and users.id = ?'+
                    'inner join trains on tickets.train = trains.id '+
                    'inner join types on trains.type = types.id';
        const { name, totalFare } = (await runQuery(sql, [parseInt(uid, 10)]))[0];
        return res.send('Total fare of ${name} is ${totalFare} KRW');
    } catch(err){
        console.error(err);
        return res.sendStatus(500);
    }
});

app.get('/train/status', async(req, res, next) => { 
    try{
        const { tid } = req.query;
        const sql = 'select count(*) as occupied, max_seats as maximum from tickets '+
                    'inner join types on trains.type=types.id and tickets.train= ? ';
        const { occupied, maximum } = (await runQuery(sql, [parseInt(tid, 10)]))[0];
        const isSeatsLeft = occupied < maximum;
        return res.send('Train ${tid} is ', isSeatsLeft ? 'not sold out ' : 'sold out');
    } catch(err){
        console.error(err);
        return res.sendStatus(500);
    }
});


app.listen(port, () => console.log(`Server listening on port ${port}!`));