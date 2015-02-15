curl -X GET \
  -H "X-Parse-Application-Id: 67k8jnSI757kUzLNletpqjxMHdBWTbELiyJoMy52" \
  -H "X-Parse-REST-API-Key: BZi6qS4QKjblJvrlvOq8veoSgO3F5cJj7zLciYrs" \
  --data-urlencode 'username=ParseMasterOperation' \
  --data-urlencode 'password=sjtumems315' \
  https://api.parse.com/1/login


curl -X PUT \
  -H "X-Parse-Application-Id: 67k8jnSI757kUzLNletpqjxMHdBWTbELiyJoMy52" \
  -H "X-Parse-REST-API-Key: BZi6qS4QKjblJvrlvOq8veoSgO3F5cJj7zLciYrs" \
  -H "X-Parse-Session-Token: MoGyejL0btpLM7vrEKuen6a1x" \
  -H "Content-Type: application/json" \
  -d '{"pageViewCount":{"__op":"Increment","amount":1}}' \
  https://api.parse.com/1/classes/Article/9P9akzafUV


curl -X PUT \
  -H "X-Parse-Application-Id: 67k8jnSI757kUzLNletpqjxMHdBWTbELiyJoMy52" \
  -H "X-Parse-REST-API-Key: BZi6qS4QKjblJvrlvOq8veoSgO3F5cJj7zLciYrs" \
  -H "X-Parse-Session-Token: MoGyejL0btpLM7vrEKuen6a1x" \
  -H "Content-Type: application/json" \
-d '{"coverImage":{"__op":"AddRelation","objects":[{"__type":"Pointer","className":"StreetImage","objectId":"Xa7Np7HHAS"}]}}' \
https://api.parse.com/1/classes/Session/HyP0KLskQh