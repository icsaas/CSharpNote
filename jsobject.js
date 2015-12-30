var Cat = {
	name:'',
	color:''
}

var cat1 = {}
cat1.name="name1";
cat1.color="yellow";

var cat2 = {}
cat2.name = 'name2';
cat2.color='red';

function Cat(name,color){
	return {
		name:name,
		color:colr
	}
}

var cat1=Cat("name1","yellow");
var cat2 = Cat("name2","black");


function Cat(name,color){
	this.name=name;
	this.color=color;
}

Cat.prototype.type="cat"
Cat.prototype.eat=function(){alert("eat mouse");}


var cat1 = new Cat("name1","yellow");
var cat2 = new Cat("name2","black");

//inherits
function Animal(){
	this.species="animal";
}

//call or apply
function Cat(name,color){
	Animal.apply(this.arguments);
	this.name=name;
	this.color = color;

}



//prototype pattern
Cat.prototype = new Animal();
Cat.prototype.constructor=Cat;
var cat1 =new Cat("name1","Yellow")
alert(cat1.species);


