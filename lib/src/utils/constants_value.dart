class ConstantsValue {
  static String getLabel(String key, String type) {
    if (type == 'coldChain') {
      if (key == '') return '전체';
      if (key == 'PHARMA') return '냉장';
      if (key == 'FROZEN') return '냉동1';
      if (key == 'DEEP_FREEZE') return '냉동2';
      if (key == 'ETC') return '사용자 설정';
      return '';
    }
    if (type == 'periodType') {
      if (key == 'DEPARTURE_DATE') return '출발일';
      if (key == 'ARRIVAL_DATE') return '도착일';
      return '';
    }
    return '';
  }
}
