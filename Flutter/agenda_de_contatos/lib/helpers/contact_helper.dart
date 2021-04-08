import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String idContato = "idContato";
final String nomeContato = "nomeContato";
final String emailContato = "emailContato";
final String telefoneContato = "telefoneContato";
final String imgContato = "imgContato";

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();
  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final dataBasesPath = await getDatabasesPath();
    final path = join(dataBasesPath, "contatosdb.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute("CREATE TABLE contatos("
          "$idContato INTEGER PRIMARY KEY,"
          "$nomeContato TEXT,"
          "$emailContato TEXT,"
          "$telefoneContato TEXT,"
          "$imgContato TEXT)");
    });
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert("contatos", contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query("contatos",
        columns: [
          idContato,
          nomeContato,
          emailContato,
          telefoneContato,
          imgContato
        ],
        where: "$idContato = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;

    return await dbContact
        .delete("contatos", where: "$idContato = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;

    return await dbContact.update("contatos", contact.toMap(),
        where: "$idContato = ?", whereArgs: [contact.id]);
  }

  Future<List<Contact>> getAllContact() async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.rawQuery("SELECT * FROM contatos");
    List<Contact> listContact = List();
    for (Map m in maps) {
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  Future<int> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery(("SELECT COUNT(id) FROM contatos")));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}

class Contact {
  int id;
  String nome;
  String email;
  String telefone;
  String img;


  Contact(this.nome, this.email, this.telefone, this.img);

  Contact.fromMap(Map map) {
    this.id = map[idContato];
    this.nome = map[nomeContato];
    this.email = map[emailContato];
    this.telefone = map[telefoneContato];
    this.img = map[imgContato];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nomeContato: this.nome,
      emailContato: this.email,
      telefoneContato: this.telefone,
      imgContato: this.img,
    };
    if (this.id != null) map[idContato] = this.id;
    return map;
  }

  @override
  String toString() {
    return "Contato(id: $id nome: $nome)";
  }
}
