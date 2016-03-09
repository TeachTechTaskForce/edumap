var fs = require('fs');
var casper = require('casper').create({
	/*verbose: true,
	logLevel: 'debug'*/
});

var URL = 'https://code.org/curriculum/';
var OUTFILE = casper.cli.get('o') || casper.cli.get('outfile') || 'lesson-times.csv';
var GLOBAL = {};
var CODE_ORG = {
	'course1': {id: 1, count: 18},
	'course2': {id: 2, count: 19},
	'course3': {id: 3, count: 21},
	'algebra': {id: 4, count: 20}
}

casper.start(URL);

casper.then(function(){
	
	GLOBAL.lessons = [];
	
	for(var course in CODE_ORG){
		for(var lessonID = 1; lessonID <= CODE_ORG[course].count; lessonID++){
			scrapeLesson(course, lessonID);
		}
	}

});

casper.then(function(){
	casper.echo('----- DONE -----');
});

casper.then(function(){
	fs.write(OUTFILE, '', 'w');
	var header = '';
	for(var prop in GLOBAL.lessons[0]){
		header += prop + ',';
	}
	fs.write(OUTFILE, header += '\r\n', 'a');
	for(var s = 0; s < GLOBAL.lessons.length; s++){
		var dataString = '';
		for(var prop in GLOBAL.lessons[s]){
			dataString += casper.wrap(GLOBAL.lessons[s][prop]) + ',';
		}
		fs.write(OUTFILE, dataString += '\r\n', 'a');
	}
	casper.echo('Data written to file: ' + OUTFILE);
});

casper.run();

function scrapeLesson(course, lessonID){

	var LESSON_URL = URL + course + "/" + lessonID + "/Teacher";

	casper.thenOpen(LESSON_URL, function(){
		casper.echo("Opened: " + LESSON_URL);
	}).waitForSelector('#bottom', function(){
		var page = casper.evaluate(function(){
			var header = document.getElementById('bottom').innerText.split('\n');
			var title = header[1];
			var timeHeader = header[2].split('Lesson time: ')[1].split(' Minutes');
			var time = timeHeader[0] + ' Minutes';
			return {
				title: title,
				time: time
			}
		});
		var lesson = {
			url: LESSON_URL,
			curriculum: 'Code.org',
			name: CODE_ORG[course].id + '.' + lessonID + ' ' + page.title,
			time: page.time
		}
		//casper.echoObject(lesson, true);
		GLOBAL.lessons.push(lesson);
	});
}

//Custom functions added to casper for debugging process

/*
 * Wraps a string in double quotes before outputting
 */
casper.wrap = function(dataString){
	return "\"" + dataString + "\"";
}

/*
 * Prints an object representation to the console
 * obj (object): object to print
 * tree (boolean): if true, print in tree format, if false, stringified
 */
casper.echoObject = function(obj, tree){
	var treeform = tree || false;
	if(treeform){
		for(var props in obj){
			casper.echo('---' + props + ': ' + obj[props]);
		}
	}
	else{
		casper.echo(JSON.stringify(obj));
	}
}

/*
 * Prints all objects in a list to the console
 * list (array): list of objects to print
 * tree (boolean): if true, print in tree format, if false, stringified
 */
casper.echoList = function(list, tree){
	var treeform = tree || false;
	for(var l = 0; l < list.length; l++){
		casper.echoObject(list[l], treeform);
	}
}