			   <div class="row">
							<div >
								<h2 class="section-title">Random Quotes</h2>
								<div class="column" id="quotes-area">
                                  <!--<div class="col-md-4">
                                  		<div class="quotes">
                                        <input type="checkbox" value="" class="single-quote" /> <p>Leadership has a harder job to do than just choose sides. It must bring sides together.<br><b>-Jesse Jackson</b></p>
                                      	</div>
                                    </div>
                                    <div class="col-md-4">
                                    	<div class="quotes">
                                        <input type="checkbox" value="" class="single-quote" /> <p>The existential vacuum manifests itself mainly in a state of boredom.<br><b>-Viktor Frankl</b></p>
                                    	</div>
                                    </div>-->
								</div>
							</div>
						</div>
                <script>
                var quotesArray = [];
         $(function() {
  	
   			 loadRandomQuotesComp();
             fetchQuotefavourites();
 		 }); 
         
         function addFavouriteQuotes(quote,auther) {
  
        
          var quoteObj = {}; 
          quoteObj[auther] = quote;
          quotesArray.push(quoteObj);
    
          localStorage.setItem("quotesData", JSON.stringify(quotesArray));
         
          fetchQuotefavourites();
         
        }
         
    function fetchQuotefavourites(){
                    
      $('#quotesFavourites').empty();
      var storedData = localStorage.getItem("quotesData");
      
      var favQuoteDiv = $('<div>');
      for(var i in JSON.parse(storedData)){
        var quoteAuthor = Object.keys(JSON.parse(storedData)[i]);
        var quote = JSON.parse(storedData)[i][quoteAuthor];
        
        var htmlPar = "<p>"+quote+"</br><b>-"+quoteAuthor+"</b></p>";
        favQuoteDiv.append(htmlPar);
        
      }
      $('#quotesFavourites').append('<h2>Favourite Quotes</h2>');
      $('#quotesFavourites').append(favQuoteDiv);
                    
    }
         
    function loadRandomQuotesComp() {
 
          var randomQuoteUrl = 'http://quotes.stormconsultancy.co.uk/quotes.json';
          $.ajax({
            url:randomQuoteUrl,
            dataType:'json',
            async:false,
            success:function(data){
              var author="";
              
              for(i in data){
                
                if(data[i].author!=null){
                  author= data[i].author;
                }else{
                  author="";
                }
                
                var htmlDiv ="<div class='col-md-4' ><div class='quotes'>"+
                  "<p>"+data[i].quote+"</br><b>-"+author+"</b>&nbsp&nbsp<a href='javascript:void(0);'"+
                  "onclick='addFavouriteQuotes(this.id,this.name)' id='"+data[i].quote+"' name='"+author+"'>"+
                  "<span class='glyphicon glyphicon-heart-empty'></span></a></p></div></div>";
                    
                  
                    $('#quotes-area').append(htmlDiv);
                
              }
            }
    });  
}

</script>