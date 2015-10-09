jenny = User.create(email: "leejenny0403@gmail.com", name: "Jenny Lee", password: "jenny", age: 24, gender: "female", description: "looking for someone to play tennis with me occasionally.  Would also like to try some olympics lifts :)")
mark = User.create(email: "mark.kilpatrick.miller@gmail.com", name: "Mark Miller", password: "mark", age: 24, gender: "male", description: "Looking for someone to lift with 6 nights a week.  I've only been lifting for a few years but can push some weight.  Looking for someone of any level, I'd love to bring a beginner or get pushed by someone more advanced.")
navraj = User.create(email: "nnat425@gmail.com", name: "Navraj Nat", password: "navraj", age: 22, gender: "male", description: "Looking to get back into the gym.  I know the basics but am looking for someone trying to get toned for beach body season")

lifting = Activity.create(name: "Lifting", image: "http://www.womenshealthmag.com/sites/womenshealthmag.com/files/images/beauty-weights-art.jpg")
mark.activities << lifting
jenny.activities << lifting
navraj.activities << lifting
tennis = Activity.create(name: "Tennis", image: "http://sport.maths.org/content/sites/sport.maths.org/files/iStock_Tennis_crop.jpg")
jenny.activities << tennis
basketball = Activity.create(name: "Basketball", image: "http://www.rowan.edu/studentaffairs/Rec/sports/W.%20Basketball.jpg")
mark.activities << basketball
navraj.activities << basketball
spin = Activity.create(name: "Spin", image: "http://heuserhealth.com/wp-content/uploads/2014/01/iStock_000012790937Medium.jpg")
jenny.activities << spin
mark.activities << spin
soccer = Activity.create(name: "Soccer", image: "http://rezatehranicohen.info/wp-content/uploads/rezatehranicohen-info/sites/593/Document.jpeg")
navraj.activities << soccer