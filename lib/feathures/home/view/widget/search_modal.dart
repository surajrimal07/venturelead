import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';

class SearchController extends GetxController {
  var isVerified = false.obs;
  var isNearby = false.obs;
  var selectedSector = <String>[].obs;
  var selectedRevenue = <String>[].obs;
  var selectedBusinessModel = <String>[].obs;
  var selectedCity = <String>[].obs;
}

class SearchFilterModal extends StatefulWidget {
  SearchFilterModal({super.key});
  final SearchController controller = Get.put(SearchController());

  @override
  State<SearchFilterModal> createState() => _SearchFilterModalState();
}

class _SearchFilterModalState extends State<SearchFilterModal> {
  bool isRevenueExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Companies'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Sort by:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  DropdownButton<String>(
                    value: 'Relevance',
                    items: <String>['Relevance', 'Name', 'Date']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Obx(() => SwitchListTile(
                    title: const Text('Display only verified companies'),
                    value: widget.controller.isVerified.value,
                    onChanged: (bool value) {
                      widget.controller.isVerified.value = value;
                    },
                    activeTrackColor: Colors.red[200],
                    activeColor: Colors.red,
                  )),
              Obx(() => SwitchListTile(
                    title: const Text('Display only nearby companies'),
                    value: widget.controller.isNearby.value,
                    onChanged: (bool value) {
                      widget.controller.isNearby.value = value;
                    },
                    activeTrackColor: Colors.red[200],
                    activeColor: Colors.red,
                  )),
              buildSectionTitle('SECTORS'),
              buildCheckboxList(
                [
                  'AdTech',
                  'Administrative Services',
                  'Aerospace & Defense',
                  'AgriTech',
                  'EdTech',
                ],
                widget.controller.selectedSector,
              ),
              buildSectionTitle('REVENUE STREAM'),
              buildCheckboxList(
                [
                  'Advertising',
                  'Product Sales',
                  'Commission on transaction',
                  'Donations',
                  'E-commerce-Product',
                ],
                widget.controller.selectedRevenue,
              ),
              buildSectionTitle('BUSINESS MODEL'),
              buildChipList(
                [
                  'B2B',
                  'B2B2C',
                  'B2C',
                  'B2G',
                  'C2C',
                  'D2C',
                ],
                widget.controller.selectedBusinessModel,
              ),
              buildSectionTitle('City'),
              buildChipList(
                [
                  'Kathmandu',
                  'Pokhara',
                  'Bharatpur',
                  'Dharan',
                  'Lalitpur',
                  'Jhapa',
                  'Simara',
                  'Dhangadhi',
                  'Butwal',
                  'Biratnagar',
                ],
                widget.controller.selectedCity,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      widget.controller.isVerified.value = false;
                      widget.controller.isNearby.value = false;
                      widget.controller.selectedSector.clear();
                      widget.controller.selectedRevenue.clear();
                      widget.controller.selectedBusinessModel.clear();
                      widget.controller.selectedCity.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Reset Filters',
                        style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // final searchResults = searchCompanies(
                      //     companyController.getCompanies, searchText);

                      Navigator.pop(context);
                      HomeController.to.selectedIndex.value = 6;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('See Results',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildCheckboxList(List<String> items, RxList<String> selectedItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Obx(() {
          bool isSelected = selectedItems.contains(item);
          return CheckboxListTile(
            title: Text(item),
            value: isSelected,
            onChanged: (bool? value) {
              if (value == true) {
                selectedItems.add(item);
              } else {
                selectedItems.remove(item);
              }
            },
            activeColor: Colors.red,
          );
        });
      }).toList(),
    );
  }

  Widget buildChipList(List<String> items, RxList<String> selectedItems) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: items.map((item) {
        return Obx(() => FilterChip(
              label: Text(item),
              selectedColor: Colors.red[100],
              selected: selectedItems.contains(item),
              onSelected: (bool value) {
                if (value) {
                  selectedItems.add(item);
                } else {
                  selectedItems.remove(item);
                }
              },
            ));
      }).toList(),
    );
  }
}
