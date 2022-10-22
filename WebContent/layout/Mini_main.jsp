 <%--==============================================================
 * index 메인 이미지 캐러셀 화면
 * @author 문성철
 * @since  2017.02.22
 * @version 1.0
 * 
===============================================================--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container">
  <br>
  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <!-- <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
      <li data-target="#myCarousel" data-slide-to="3"></li>
    </ol> -->

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">

      <div class="item active">
        <img src="http://pingendo.github.io/pingendo-bootstrap/assets/blurry/800x600/13.jpg" alt="1" width="460" height="345">
        <div class="carousel-caption">
        </div>
      </div>
      
      <div class="item">
        <img src="http://pingendo.github.io/pingendo-bootstrap/assets/blurry/800x600/16.jpg" alt="2" width="460" height="345">
        <div class="carousel-caption">
        </div>
      </div>
      
      <div class="item">
        <img src="http://pingendo.github.io/pingendo-bootstrap/assets/blurry/800x600/10.jpg" alt="3" width="460" height="345">
        <div class="carousel-caption">
        </div>
      </div>
      
      <div class="item">
        <img src="http://pingendo.github.io/pingendo-bootstrap/assets/blurry/800x600/8.jpg" alt="4" width="460" height="345">
        <div class="carousel-caption">
        </div>
      </div>
  
    </div>
<!--     <div class="carousel-inner" role="listbox">

      <div class="item active">
        <img src="./backimg/1.jpg" alt="1" width="460" height="345">
        <div class="carousel-caption">
        </div>
      </div>
      
      <div class="item">
        <img src="./backimg/2.jpg" alt="2" width="460" height="345">
        <div class="carousel-caption">
        </div>
      </div>
      
      <div class="item">
        <img src="./backimg/3.jpg" alt="3" width="460" height="345">
        <div class="carousel-caption">
        </div>
      </div>
      
      <div class="item">
        <img src="./backimg/4.jpg" alt="4" width="460" height="345">
        <div class="carousel-caption">
        </div>
      </div>
  
    </div> -->

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</div>
