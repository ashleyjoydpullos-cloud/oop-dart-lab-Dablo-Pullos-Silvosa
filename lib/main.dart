import 'dart:io';


class Person {
  String _name;
  int _age;

  Person(this._name, this._age);

  String get name => _name;
  int get age => _age;

  set age(int value) {
    if (value < 0) {
      throw ArgumentError('Age cannot be negative.');
    }
    _age = value;
  }

  String introduce() {
    return "Hi, I'm $_name, $_age years old.";
  }
}


class Student extends Person {
  String _course;

  Student(String name, int age, this._course) : super(name, age);

  String get course => _course;

  @override
  String introduce() {
    return "Hi, I'm $_name, $_age years old, studying $_course.";
  }
}


class Teacher extends Person {
  String _subject;

  Teacher(String name, int age, this._subject) : super(name, age);

  String get subject => _subject;

  @override
  String introduce() {
    return "Hi, I'm $_name, $_age years old, teaching $_subject.";
  }
}


class School {
  final List<Person> _people = [];

  void addPerson(Person p) {
    _people.add(p);
  }

  void introduceAll() {
    for (final person in _people) {
      print(person.introduce());
    }
  }
}




String readNonEmptyText(String prompt) {
  while (true) {
    stdout.write(prompt);
    final input = stdin.readLineSync();
    if (input != null && input.trim().isNotEmpty) {
      return input.trim();
    }
    print('  This field cannot be empty. Please try again.');
  }
}


int readNonNegativeInt(String prompt) {
  while (true) {
    stdout.write(prompt);
    final input = stdin.readLineSync();
    final value = int.tryParse((input ?? '').trim());
    if (value == null) {
      print('  Please enter a valid whole number.');
      continue;
    }
    if (value < 0) {
      print('  Age cannot be negative. Please try again.');
      continue;
    }
    return value;
  }
}


int readCount(String prompt) {
  while (true) {
    stdout.write(prompt);
    final input = stdin.readLineSync();
    final value = int.tryParse((input ?? '').trim());
    if (value == null || value < 0) {
      print('  Please enter a valid non-negative whole number.');
      continue;
    }
    return value;
  }
}


void main() {
  print('=== School Personnel Management ===');
  final school = School();

  int studentTotal = 0;
  int teacherTotal = 0;

  final studentCount = readCount('How many students will you add? ');

  for (var i = 1; i <= studentCount; i++) {
    print('\n-- Student #$i --');

    final name = readNonEmptyText('  Name: ');
    final age = readNonNegativeInt('  Age: ');
    final course = readNonEmptyText('  Course: ');

    school.addPerson(Student(name, age, course));

    studentTotal++;
    print('  Student added! Total students: $studentTotal');
  }

  final teacherCount = readCount('\nHow many teachers will you add? ');

  for (var i = 1; i <= teacherCount; i++) {
    print('\n-- Teacher #$i --');

    final name = readNonEmptyText('  Name: ');
    final age = readNonNegativeInt('  Age: ');
    final subject = readNonEmptyText('  Subject: ');

    school.addPerson(Teacher(name, age, subject));

    teacherTotal++;
    print('  Teacher added! Total teachers: $teacherTotal');
  }

  final totalPersonnel = studentTotal + teacherTotal;

  print('\n=== School Roster ===');
  school.introduceAll();

  print('\n=== Personnel Count ===');
  print('Total Students: $studentTotal');
  print('Total Teachers: $teacherTotal');
  print('Total Personnel: $totalPersonnel');
}