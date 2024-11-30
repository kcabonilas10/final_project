class User {  
  final String id;  
  final String email;  
  final String? displayName;  
  final String? photoURL;  
  final bool emailVerified;  

  User({  
    required this.id,  
    required this.email,  
    this.displayName,  
    this.photoURL,  
    this.emailVerified = false,  
  });  

  factory User.fromJson(Map<String, dynamic> json) {  
    return User(  
      id: json['id'] as String,  
      email: json['email'] as String,  
      displayName: json['displayName'] as String?,  
      photoURL: json['photoURL'] as String?,  
      emailVerified: json['emailVerified'] as bool? ?? false,  
    );  
  }  

  Map<String, dynamic> toJson() {  
    return {  
      'id': id,  
      'email': email,  
      'displayName': displayName,  
      'photoURL': photoURL,  
      'emailVerified': emailVerified,  
    };  
  }  

  User copyWith({  
    String? id,  
    String? email,  
    String? displayName,  
    String? photoURL,  
    bool? emailVerified,  
  }) {  
    return User(  
      id: id ?? this.id,  
      email: email ?? this.email,  
      displayName: displayName ?? this.displayName,  
      photoURL: photoURL ?? this.photoURL,  
      emailVerified: emailVerified ?? this.emailVerified,  
    );  
  }  
}