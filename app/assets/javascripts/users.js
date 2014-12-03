// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

//Selects a file with a button calling a hidden form input
document.getElementById("inputButton").addEventListener("click", chooseFile);
function chooseFile() {
  $("#fileInput").click();
}

//Submits the file with a button calling a hidden form submit button
document.getElementById("submit-btn").addEventListener("click", submitFile);
function submitFile(event) {
  event.preventDefault();
  $("#edit_user_2").submit();
};

//Previews the image before it's saved
document.getElementById('fileInput').addEventListener('change', handleFileSelect, false);
function handleFileSelect(event){
  var files = event.target.files;
  if (files[0] != undefined && files[0].type.match('image.*')){
  	var reader = new FileReader();
      reader.onload = (function(theFile) {
        return function(e) {
	      document.getElementById("userAvatar").src = e.target.result;
      };
      })(files[0]);
      reader.readAsDataURL(files[0]);
  }
};