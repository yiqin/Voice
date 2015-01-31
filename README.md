# Purdue Voice
*The next big thing*


---
## Voice API Documentation
Currently the backend is built on Parse. 


Information from website to backend on Parse will be saved to SessionBeta, StreetImageBeta, StreetDetailImageBeta and ArticleBeta first. Then, we need to confirm it by migrate the data from Beta to no-Beta that is official in iOS app. The reason 

How to confirm a merge? But you need an interface for managers to operate on it..
but .. adding the articles from the edit website into the app database is already an administrative job that is confirmed by administrator.

I will setup code in the backend later. Yes
Just add Beta to the query request.
Some users are admin users, who will have the right to do that. Or we can setup the background job on backend to do that at the right time.

To avoid some information missing or some information not in the correct format. This will cause crashing.

What is a session? ok
期刊

What is the difference between StreetImageBeta and StreetDetailImageBeta . OK i got it.
StreetImageBeta is the cover image of a bundle of street images. StreetDetailImageBeta are these street images. 


All classes have
objectId : String

SessionBeta
期刊, 第一期，第二期
Cover Image is StreetImageBeta.
isPublished : Boolean
number : Number
title : String

StreetImageBeta
belongTo : Pointer  SessionBeta
image : File 
	Size Specification - I have designed the image dynamically fit the size of the iPhone. The backend code also checks the ratio of the image width/ the image height.
	what about file size? less than 10 MB
photoBy : String
who : String

StreetDetailImageBeta
belongTo : Pointer  StreetImageBeta
image : File
imageHeight : Number ** so i need to calculate this before upload? No. imageHeight is a no used value at this time. But we maybe need this in the future. lol
indexNumber : Number ** what about this? should I setup this value? Yes. It’s the sequence of  street images. Street images should be in a order.
description : String  ** About the interview transcripts.


ArticleBeta
belongTo : Pointer SessionBeta
briefImage : File
title : String
writerName : String
url : String
	The link to http://edit.imvoice.me article website.



Session
			/	\
	StreetImage		Article
	       /
StreetDetailImage

can a single session contain a list of StreetImage
Yes. Maybe no.???? We probabley have several StreetImages in a Session. Each session could have more bundles of street images. 

Then does a StreetImage has a index prop to save the order?
** StreetImage?
This can be added later.
We can add an index. ok

For example, the session is one bundle of street images and several articles.
In the future, we can also have one bundle of street images, another bundle of street images and another bundle, but zero articles……
It’s more flexible.

If we just set a single session contain a list of StreetImage, it’s impossible to modify the database in the future.

Let me know if there are any questions. The problem is we need to predict the future use of the backend. We need to make the backend be flexible. Even we add, or delete, or change something, the iOS app won’t crash. (It will crash now.. So we need.)
okok

what about the ads?
When these are stable, we add ads. Ads cause crash last time. Then I realized that we need to be very very cautious.
okok

does iOS have a file socket tunnel? em not curl
Parse provides the secure protect. Don’t put the api key in the public on the web.
If I use the auth way, then u need to make a user system. otherwise there’s no way to check the authentication of a user, then I need to use key pair version until you have a user system.
That comes later.





We will show some examples about how to use Voice API first. Then we show the detail of each class.

---
##
Example

---
####
User
We have setup Anonymous users. WeChat login and facebook login come later.

---
####
Ad

---
####
AdImage


---
####
AdsLocation

---
####
Article

---
####
ArticleBlock


---
####
Hashtag


---
####
StreetDetailImage


---
####
StreetImage


---
####
Tagging









