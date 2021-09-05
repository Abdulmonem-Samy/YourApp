
class ProfileModel{
  String name='';
  String uid='';
  String description='';
  String creationTime='';
  String lastLoginTime='';
  String sex='';
  String birthDay='';
  String profileState='';
  String job='';
  num profileStrength=0;
  List specialsList=[];//peoples to share with only or excepted.
  bool specialFlag=true;//flag =true if share with special people and false if blocked
  List followersUid=[];
  List likedId=[];
  List posts=[];
  List picFiles=[r'https://cdn.dribbble.com/users/844846/screenshots/2855815/no_image_to_show_.jpg'];

  ProfileModel();

  set(Map<String?,dynamic> data){
    uid=data['uid'];
    name=data['name'];
    description=data['description'];
    creationTime=data['creationTime'];
    lastLoginTime=data['lastLoginTime'];
    profileState=data['profileState'];
    sex=data['sex'];
    job=data['job'];
    birthDay=data['birthDay'];
    profileStrength=data['profileStrength'];
    specialsList=data['specialsList'];
    specialFlag=data['specialFlag'];
    followersUid=data['followersUid'];
    likedId=data['likedId'];
    posts=data['posts'];
    picFiles=data['picFiles'];
  }

  Map<String,dynamic> get(){
    Map<String,dynamic> data={};
    data['uid']=uid;
    data['name']=name;
    data['description']=description;
    data['creationTime']=creationTime;
    data['lastLoginTime']=lastLoginTime;
    data['profileState']=profileState;
    data['job']=job;
    data['sex']=sex;
    data['birthDay']=birthDay;
    data['profileStrength']=profileStrength;
    data['specialsList']=specialsList;
    data['specialFlag']=specialFlag;
    data['followersUid']=followersUid;
    data['likedId']=likedId;
    data['posts']=posts;
    data['picFiles']=picFiles;
    return data;
  }
}