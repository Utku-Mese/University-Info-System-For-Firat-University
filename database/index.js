// imports
const express = require('express');
const app = express();
const PORT = 8000;
const db = require('./data/db');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// "/api/students/:id" deletes a student by id
app.delete("/api/students/:id", async (req, res) => {
    try {
        await db.query("DELETE FROM students WHERE id = ?", [req.params.id]);
        res.send("Student deleted");
        console.log("Student deleted");
    } catch (err) {
        console.log(err);
    }
});

// "/api/lessons/:id" deletes a lessons by id
app.delete("/api/lessons/:id", async (req, res) => {
    try {
        await db.query("DELETE FROM lessons WHERE id = ?", [req.params.id]);
        res.send("lessons deleted");
        console.log("lessons deleted");
    } catch (err) {
        console.log(err);
    }
});

// "/api/instructors/:id" deletes a instructors by id
app.delete("/api/instructors/:id", async (req, res) => {
    try {
        await db.query("DELETE FROM instructors WHERE id = ?", [req.params.id]);
        res.send("instructors deleted");
        console.log("instructors deleted");
    } catch (err) {
        console.log(err);
    }
});

// "/api/students/:id" update student by id
app.put("/api/students/:id", async (req, res) => {
    try {
        const studentId = parseInt(req.params.id);
        const { name, surname, department, grade, email, isActive, gender, phoneNumber, adress, gpa, imageUrl } = req.body;

        const query = `
            UPDATE students
            SET name = ?, surname = ?, department = ?, grade = ?, email = ?, isActive = ?, gender = ?, phoneNumber = ?, adress = ?, gpa = ?, imageUrl = ?
            WHERE id = ?
        `;

        const values = [name, surname, department, grade, email, isActive, gender, phoneNumber, adress, gpa, imageUrl, studentId];

        // Undefined değerleri JS null ile değiştir
        const sanitizedValues = values.map(value => (value !== undefined) ? value : null);

        await db.execute(query, sanitizedValues);

        res.send("Öğrenci güncellendi");
        console.log("Öğrenci güncellendi");
    } catch (err) {
        console.log(err);
    }
});

// "/api/lessons/:id" updates lessons by id
app.put("/api/lessons/:id", async (req, res) => {
    try {
        const lessonId = parseInt(req.params.id);
        const { name, shortName, descriptions, department, grade, credit, obligation, instructor } = req.body;

        const query = `
            UPDATE lessons
            SET name = ?, shortName = ?, descriptions = ?, department = ?, grade = ?, credit = ?, obligation = ?, instructor = ?
            WHERE id = ?
        `;

        const values = [name, shortName, descriptions, department, grade, credit, obligation, instructor, lessonId];


        const sanitizedValues = values.map(value => (value !== undefined) ? value : null);

        await db.execute(query, sanitizedValues);

        res.send("Ders güncellendi");
        console.log("Ders güncellendi");
    } catch (err) {
        console.log(err);
    }
});

// "/api/instructors/:id" updates instructors by id
app.put("/api/instructors/:id", async (req, res) => {
    try {
        const instructorId = parseInt(req.params.id);
        const { name, surname, department, email, isActive, gender, phoneNumber, adress, imageUrl } = req.body;

        const query = `
            UPDATE instructors
            SET name = ?, surname = ?, department = ?, email = ?, isActive = ?, gender = ?, phoneNumber = ?, adress = ?, imageUrl = ?
            WHERE id = ?
        `;

        const values = [name, surname, department, email, isActive, gender, phoneNumber, adress, imageUrl, instructorId];


        const sanitizedValues = values.map(value => (value !== undefined) ? value : null);

        await db.execute(query, sanitizedValues);

        res.send("Eğitmen güncellendi");
        console.log("Eğitmen güncellendi");
    } catch (err) {
        console.log(err);
    }
});

// "/api/instructors/:id" gets a instructors by id
app.use("/api/instructors/:id", async (req, res) => {
    try {
        const [instructors,] = await db.execute("SELECT * FROM instructors WHERE id = ?", [req.params.id]);
        res.send(instructors);
    } catch (err) {
        console.log(err);
    }
});

// "/api/lessons/:id" gets a lessons by id
app.use("/api/lessons/:id", async (req, res) => {
    try {
        const [lessons,] = await db.execute("SELECT * FROM lessons WHERE id = ?", [req.params.id]);
        res.send(lessons);
    } catch (err) {
        console.log(err);
    }
});




// "/api/students/:id" gets a student by id
app.use("/api/students/:id", async (req, res) => {
    try {
        const [student,] = await db.execute("SELECT * FROM students WHERE id = ?", [req.params.id]);
        res.send(student);
    } catch (err) {
        console.log(err);
    }
});




// post lessons
app.post("/api/lessons", (req, res) => {
    console.log(req.body);
    const { name, shortName, descriptions, department, grade, credit, obligation, instructor } = req.body;

    const query = "INSERT INTO lessons (name, shortName, descriptions, department, grade, credit, obligation, instructor) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    const values = [name, shortName, descriptions, department, grade, credit, obligation, instructor];

    // Undefined değerleri JS null ile değiştir
    const sanitizedValues = values.map(value => (value !== undefined) ? value : null);

    db.execute(query, sanitizedValues);
});

// post instructors
app.post("/api/instructors", (req, res) => {
    console.log(req.body);
    const { name, surname, department, email, isActive, gender, phoneNumber, adress, imageUrl } = req.body;

    const query = "INSERT INTO instructors (name, surname, department, email, isActive, gender, phoneNumber, adress, imageUrl) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    const values = [name, surname, department, email, isActive, gender, phoneNumber, adress, imageUrl];

    // Undefined değerleri JS null ile değiştir
    const sanitizedValues = values.map(value => (value !== undefined) ? value : null);

    db.execute(query, sanitizedValues);
});

// post student
app.post("/api/students", (req, res) => {
    console.log(req.body);
    const { name, surname, department, grade, email, isActive, gender, phoneNumber, adress, gpa, imageUrl } = req.body;

    const query = "INSERT INTO students (name, surname, department, grade, email, isActive, gender, phoneNumber, adress, gpa, imageUrl) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    const values = [name, surname, department, grade, email, isActive, gender, phoneNumber, adress, gpa, imageUrl];

    // Undefined değerleri JS null ile değiştir
    const sanitizedValues = values.map(value => (value !== undefined) ? value : null);

    db.execute(query, sanitizedValues);

});

// "/api/students" gets all students
app.use("/api/students", async (req, res) => {

    try {
        const [students,] = await db.execute("SELECT * FROM students")
        res.send(students);
    } catch (err) {
        console.log(err);
    }
});



// "/api/instructors" gets all instructors
app.use("/api/instructors", async (req, res) => {

    try {
        const [instructors,] = await db.execute("SELECT * FROM instructors")
        res.send(instructors);
    } catch (err) {
        console.log(err);
    }
})

// "/api/lessons" gets all lessons
app.use("/api/lessons", async (req, res) => {

    try {
        const [lessons,] = await db.execute("SELECT * FROM lessons")
        res.send(lessons);
    } catch (err) {
        console.log(err);
    }
})

// "/api" is the api info of the server
app.use("/api", (req, res) => {
    res.sendFile("apiInfo.html", { root: __dirname });

});


// "/" is the root of the server
app.use("/", (req, res) => {
    res.send("Welcome to my server!");

});




// listen
app.listen(PORT, () => {
    console.log('Server is running on port ' + PORT);
});