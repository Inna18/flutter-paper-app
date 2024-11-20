import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paper_app/src/models/trace.dart';
import 'package:paper_app/src/widgets/custom_date_picker.dart';

class SearchFilter extends ConsumerStatefulWidget {
  SearchFilter({required this.fetchTrace, super.key});

  void Function(Map<String, String> params) fetchTrace;

  @override
  ConsumerState<SearchFilter> createState() {
    return _SearchFilterState();
  }
}

class _SearchFilterState extends ConsumerState<SearchFilter> {
  SearchPeriodType searchType = SearchPeriodType.departureAt;
  DateTime startAt = DateTime.utc(1900, 1, 1);
  DateTime endAt = DateTime.now();
  String searchColdChain = '';
  String keyword = '';

  void _changeSelectPeriodType(SearchPeriodType periodType) {
    setState(() {
      searchType = periodType;
    });
  }

  void _selectRange(List<DateTime> date) {
    startAt = date[0];
    endAt = date[1];
  }

  void _changeSearchColdChain(String coldType) {
    setState(() {
      searchColdChain = coldType;
    });
  }

  void _search() {
    Map<String, String> params = {
      'periodType': searchType.name,
      'startDate': DateFormat('yyyy-MM-dd').format(startAt),
      'endDate': DateFormat('yyyy-MM-dd').format(endAt),
      'coldChainType': searchColdChain,
      'keyword': keyword,
      'page': '0',
      'size': '10',
    };
    Navigator.of(context).pop();
    widget.fetchTrace(params);
  }

  String _getLabel(String coldChain) {
    if (coldChain == '') return '전체';
    if (coldChain == 'PHARMA') return '냉장';
    if (coldChain == 'FROZEN') return '냉동1';
    if (coldChain == 'DEEP_FREEZE') return '냉동2';
    if (coldChain == 'ETC') return '사용자 설정';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom > 40
                  ? 0
                  : 40 - MediaQuery.of(context).viewInsets.bottom),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('검색', style: TextStyle(fontSize: 18)),
            ],
          ),
          const Divider(color: Color.fromRGBO(214, 220, 237, 1)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('기간', style: TextStyle()),
            ],
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                  children: SearchPeriodType.values
                      .map(
                        (periodType) => InkWell(
                          onTap: () => _changeSelectPeriodType(periodType),
                          splashFactory: NoSplash.splashFactory,
                          highlightColor: Colors.transparent,
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: searchType == periodType
                                ? const EdgeInsets.only(bottom: 0.1)
                                : const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: searchType == periodType
                                  ? const Color.fromRGBO(37, 122, 240, 1)
                                  : Colors.transparent,
                              width:
                                  1.0, // This would be the width of the underline
                            ))),
                            child: Text(
                              periodType.name == 'DEPARTURE_DATE'
                                  ? '출발일자'
                                  : '도착일자',
                              style: searchType == periodType
                                  ? const TextStyle(
                                      color: Color.fromRGBO(37, 122, 240, 1),
                                      decorationColor:
                                          Color.fromRGBO(37, 122, 240, 1),
                                    )
                                  : const TextStyle(
                                      color: Color.fromRGBO(214, 220, 237, 1)),
                            ),
                          ),
                        ),
                      )
                      .toList()),
            ),
          ),
          CustomDatePicker(selectRange: _selectRange),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('유형', style: TextStyle()),
            ],
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                  children: ['', 'PHARMA', 'FROZEN', 'DEEP_FREEZE', 'ETC']
                      .map(
                        (coldChain) => InkWell(
                          onTap: () => _changeSearchColdChain(coldChain),
                          splashFactory: NoSplash.splashFactory,
                          highlightColor: Colors.transparent,
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: searchColdChain == coldChain
                                ? const EdgeInsets.only(bottom: 0.1)
                                : const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: searchColdChain == coldChain
                                  ? const Color.fromRGBO(37, 122, 240, 1)
                                  : Colors.transparent,
                              width:
                                  1.0, // This would be the width of the underline
                            ))),
                            child: Text(
                              _getLabel(coldChain),
                              style: searchColdChain == coldChain
                                  ? const TextStyle(
                                      color: Color.fromRGBO(37, 122, 240, 1),
                                      decorationColor:
                                          Color.fromRGBO(37, 122, 240, 1),
                                    )
                                  : const TextStyle(
                                      color: Color.fromRGBO(214, 220, 237, 1)),
                            ),
                          ),
                        ),
                      )
                      .toList()),
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom > 8
                  ? 0
                  : 8 - MediaQuery.of(context).viewInsets.bottom),
          TextField(
            onChanged: (value) => {keyword = value},
            decoration: InputDecoration(
                hintText: '출고자, S/N, 주문번호를 입력해주세요.',
                hintStyle:
                    const TextStyle(color: Color.fromRGBO(161, 163, 179, 1)),
                contentPadding: const EdgeInsets.all(12),
                suffixIcon: const Icon(Icons.search),
                iconColor: const Color.fromRGBO(214, 220, 237, 1),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                      width: 1, color: Color.fromRGBO(214, 220, 237, 1)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(214, 220, 237, 1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8))),
          ),
          SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom > 40
                  ? 0
                  : 40 - MediaQuery.of(context).viewInsets.bottom),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: const Size(300, 54),
                padding: const EdgeInsets.all(2),
                shadowColor: Colors.transparent,
                backgroundColor: const Color.fromRGBO(76, 144, 239, 1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4))),
            onPressed: () => _search(),
            child: const Text(
              '검색',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
