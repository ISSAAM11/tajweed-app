import 'package:flutter/material.dart';

class TajweedStyles {
  static const TextStyle hamWasl = TextStyle(color: Color(0xFFAAAAAA));
  static const TextStyle slnt = TextStyle(color: Color(0xFFAAAAAA));
  static const TextStyle laamShamsiyah = TextStyle(color: Color(0xFFAAAAAA));

  static const TextStyle maddaObligatory = TextStyle(color: Color(0xFFb50568));
  static const TextStyle maddaNecessary = TextStyle(color: Color(0xFFf90792));
  static const TextStyle maddaPermissible = TextStyle(color: Color(0xFFfa8b2f));
  static const TextStyle maddaNormal = TextStyle(color: Color(0xFFfab414));

  static const TextStyle qalaqah = TextStyle(color: Color(0xFF17bbff));
  static const TextStyle ikhafa = TextStyle(color: Color(0xFF00b360));
  static const TextStyle ikhafaShafawi = TextStyle(color: Color(0xFF00b360));

  static const TextStyle iqlab = TextStyle(color: Color(0xFF26BFFD));
  static const TextStyle idghamShafawi = TextStyle(color: Color(0xFF58B800));
  static const TextStyle idghamGhunnah = TextStyle(color: Color(0xFF169200));
  static const TextStyle idghamWoGhunnah = TextStyle(color: Color(0xFF169200));
  static const TextStyle idghamMutajanisayn = TextStyle(
    color: Color(0xFFA1A1A1),
  );
  static const TextStyle idghamMutaqaribayn = TextStyle(
    color: Color(0xFFA1A1A1),
  );
  static const TextStyle ghunnah = TextStyle(color: Color(0xFFFF7E1E));
}

final tajweedStyleMap = {
  'ham_wasl': TajweedStyles.hamWasl,
  'slnt': TajweedStyles.slnt,
  'laam_shamsiyah': TajweedStyles.laamShamsiyah,
  'madda_normal': TajweedStyles.maddaNormal,
  'madda_permissible': TajweedStyles.maddaPermissible,
  'madda_necessary': TajweedStyles.maddaNecessary,
  'madda_obligatory': TajweedStyles.maddaObligatory,
  'qalaqah': TajweedStyles.qalaqah,
  'ikhafa_shafawi': TajweedStyles.ikhafaShafawi,
  'ikhafa': TajweedStyles.ikhafa,
  'iqlab': TajweedStyles.iqlab,
  'idgham_shafawi': TajweedStyles.idghamShafawi,
  'idgham_ghunnah': TajweedStyles.idghamGhunnah,
  'idgham_wo_ghunnah': TajweedStyles.idghamWoGhunnah,
  'idgham_mutajanisayn': TajweedStyles.idghamMutajanisayn,
  'idgham_mutaqaribayn': TajweedStyles.idghamMutaqaribayn,
  'ghunnah': TajweedStyles.ghunnah,
};
