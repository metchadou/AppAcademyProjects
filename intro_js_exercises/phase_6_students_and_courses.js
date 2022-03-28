function Student(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = [];
}

Student.prototype.name = function () {
  return `${this.firstName} ${this.lastName}`;
}

Student.prototype.enroll = function (newCourse) {
  if (!this.courses.includes(newCourse)) {
    if (this.hasConflict(newCourse)) {
      throw "CourseConflictError: Course overlaps with an existing course";
    }
    this.courses.push(newCourse);
    return true;
  }
  return false;
}

Student.prototype.courseLoad = function () {
  let courseLoad = {};

  this.courses.forEach(course => {
    let department = course.department;
    courseLoad[department] = courseLoad[department] || 0;
    courseLoad[department] += course.credits;
  });

  return courseLoad;
}

Student.prototype.hasConflict = function(newCourse) {
  for (let i = 0; i < this.courses.length; i++) {
    const currentCourse = this.courses[i];

    if (currentCourse.conflictsWith(newCourse)) {
      return true;
    }
  }
  return false;
}


function Course(name, department, credits, days, block) {
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.days = days;
  this.block = block;
  this.students = [];
}

Course.prototype.addStudent = function (student) {
  if (student.enroll(this)) {
    this.students.push(student);
    return true;
  }
  return false;
}

Course.prototype.conflictsWith = function(course) {
  if (this.block === course.block) {
    for (let i = 0; i < this.days.length; i++) {
      const day = this.days[i];
      if (course.days.includes(day)) {
        return true;
      }
    }
  }

  return false;
}