import 'package:mysql1/mysql1.dart';
import 'package:optyma_bloc/mysql.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
final db=new Mysql();
class AuthRepository{
  Future<void> loginAdmin (String email, String password) async{
  var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    String sqlquery;
    await db.getConnection().then((conn) {
      sqlquery = "SELECT * FROM optyma.admins WHERE email = ? AND passwrd= ? ;" ;
      try {
        conn.query(sqlquery,[email, digest]).then((results) {
          
          if(results.isNotEmpty){
            String nick=results.first[0];
            print("Successfull login for " + nick);
          }
          else{
            throw Exception ("failed login");
          }
        });
      }catch(e){
        throw Exception ("failed login");
      }
      //conn.close();
    });
  } 
}