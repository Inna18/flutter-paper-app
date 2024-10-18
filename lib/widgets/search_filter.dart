import 'package:flutter/material.dart';
import 'package:paper_app/widgets/custom_date_picker.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchFilterState();
  }
}

class _SearchFilterState extends State<SearchFilter> {
  void _selectDate(DateTime date) {}

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
                children: [
                  InkWell(
                    onTap: () {},
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    child: const Text(
                      '출발일자',
                      style: TextStyle(color: Color.fromRGBO(214, 220, 237, 1)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {},
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    child: const Text('도착일자',
                        style:
                            TextStyle(color: Color.fromRGBO(214, 220, 237, 1))),
                  ),
                ],
              ),
            ),
          ),
          CustomDatePicker(
              defaultDate: DateTime.now(), selectDate: _selectDate),
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
                children: [
                  InkWell(
                    onTap: () {},
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    child: const Text('전체',
                        style:
                            TextStyle(color: Color.fromRGBO(214, 220, 237, 1))),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {},
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    child: const Text('냉장',
                        style:
                            TextStyle(color: Color.fromRGBO(214, 220, 237, 1))),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {},
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    child: const Text('냉동1',
                        style:
                            TextStyle(color: Color.fromRGBO(214, 220, 237, 1))),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {},
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    child: const Text('냉동2',
                        style:
                            TextStyle(color: Color.fromRGBO(214, 220, 237, 1))),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {},
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    child: const Text('사용자 설정',
                        style:
                            TextStyle(color: Color.fromRGBO(214, 220, 237, 1))),
                  ),
                ],
              ),
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
