import 'package:flutter/material.dart';
import 'package:paper_app/models/trace.dart';
import 'package:paper_app/widgets/custom_date_picker.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchFilterState();
  }
}

class _SearchFilterState extends State<SearchFilter> {
  SearchPeriodType searchType = SearchPeriodType.departureAt;
  DateTime startAt = DateTime.now();
  DateTime endAt = DateTime.now();
  String searchColdChain = 'all';
  String keyword = '';

  void _changeSelectPeriodType(SearchPeriodType periodType) {
    setState(() {
      searchType = periodType;
    });
  }

  void _selectRange(List<DateTime> date) {}

  void _changeSearchColdChain(String coldType) {
    setState(() {
      searchColdChain = coldType;
    });
  }

  String _getLabel(String coldChain) {
    if (coldChain == 'all') return '전체';
    if (coldChain == 'pharma') return '냉장';
    if (coldChain == 'frozen') return '냉동1';
    if (coldChain == 'deep_freeze') return '냉동2';
    if (coldChain == 'etc') return '사용자 설정';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 40),
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
                              periodType.name == 'departureAt'
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
          CustomDatePicker(
              defaultRange: [startAt, endAt], selectRange: _selectRange),
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
                  children: ['all', 'pharma', 'frozen', 'deep_freeze', 'etc']
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
          const SizedBox(height: 8),
          TextField(
            onChanged: (value) {},
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
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
          const SizedBox(height: 40),
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
            onPressed: () {},
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
