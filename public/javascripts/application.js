// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// jQuery.ajaxSetup({  
//     'beforeSend': function (xhr) {xhr.setRequestHeader("Accept", "text/javascript")}  
// });
// 
// 
// 
// $(document).ready(function (){  
//   $('#lt-deliverable').click(function (){  
//     $.get($(this).attr('action'), $(this).serialize(), null, "script");  
//     return false;  
//   });  
// });




function toMultiDimensionalArray(array, subarraysize) {
	
	var mlarray = [], a, b;
	
	for (a = 0, b = -1; a < array.length; a++) {
		if (a % subarraysize === 0) {
			b++;
			mlarray[b] = [];
		}
		
		mlarray[b].push(array[a]);
	}
	
	return mlarray;
}

// based on http://stackoverflow.com/questions/4492385/how-to-convert-simple-array-into-two-dimensional-arraymatrix-in-javascript-or