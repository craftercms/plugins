var newsArray = [];
       
       

$(function() {
  $('#btnSearchWeather').on('click', function(event) {
    event.preventDefault();
    document.location.href = "/?q=" + $('#cityName').val();
  });
  
  var newsUrl = 'https://newsapi.org/v1/articles?source=time&sortBy=latest&apiKey=535a601896d24665a8eb934239f2634a';
  
  $('#loadingImage').show();
  
  $.ajax({
    url:newsUrl,
    dataType:'json',
    success:function(data){
      
      var colAdd = document.createDocumentFragment();
      var toAdd = document.createDocumentFragment();
      for(i in data.articles){
        
        var newDiv = document.createElement('div')
            var colDiv = document.createElement('div')
                var favUrl = data.articles[i].url;
                var newsTitle = data.articles[i].title;
                newDiv.className = 'news';
        
       
            newDiv.innerHTML = '<h3><a href="/news?url='+data.articles[i].url+'" title="'+data.articles[i].url+'">' + data.articles[i].title +'</a></h3>';
        	newDiv.innerHTML += '<p>' + data.articles[i].description + '</p>'; 
        	newDiv.innerHTML += '<a href="javascript:void(0);" onclick="addFavourites(this.id,this.name)" id="'+favUrl+'" name="'+newsTitle+'"><span class="glyphicon glyphicon-heart-empty"></span></a>';
          colDiv.className = 'col-md-6';
        colDiv.id='col'+i;
        toAdd.appendChild(newDiv);
        colAdd.appendChild(colDiv);
        
        colDiv.appendChild(toAdd);
      }
      document.getElementById('newsRow').appendChild(colAdd);
    },
    complete : function(){
      $('#loadingImage').hide();
    }
  });
  fetchfavourites();
});


 function addFavourites(newsUrl,newsTitle) {
  
      var newsObj = {}; 
      newsObj[newsTitle] = newsUrl;
      newsArray.push(newsObj);

      localStorage.setItem("newsData", JSON.stringify(newsArray));
      
      fetchfavourites();
  }
  
  function isFavNews(title, data) {
  
  	for(var i = 0; i < data.length; i++) {
      if(Object.keys(data[i])[0] === title) { console.log('true'); return true; }
    }
  }
  
  function fetchfavourites(){
  	
    $('#newsFavourites').empty();
    var storedData = localStorage.getItem("newsData");
   
    //newsArray.push(JSON.parse(storedData));
    var favDiv = $('<div>');
     for(var i in JSON.parse(storedData)){
     	var newsKey = Object.keys(JSON.parse(storedData)[i]);
        var newsValue = JSON.parse(storedData)[i][newsKey];
      	
        
        var newsLink = $('<a>', {"href" : "/news?url="+newsValue});
        
        newsLink.html(newsKey+'<br>');
        favDiv.append(newsLink);
      }
      $('#newsFavourites').append('<h2>Favourite News</h2>');
      $('#newsFavourites').append(favDiv);
}

// Get the modal
var modal = document.getElementById('imgModal');

// Get the image and insert it inside the modal - use its "alt" text as a caption
//var img = document.getElementById('myImg');
var modalImg = document.getElementById("imgInModel");
var captionText = document.getElementById("caption");
function imgclick(imgSrc, name){
    modal.style.display = "block";
    modalImg.src = imgSrc;
    captionText.innerHTML = name;
}

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks on <span> (x), close the modal
if(span != undefined) {
span.onclick = function() { 
    modal.style.display = "none";
}
}