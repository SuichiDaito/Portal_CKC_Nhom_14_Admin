import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lop_bloc.dart';
import 'package:portal_ckc/bloc/state/lop_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DanhSachLopSheet extends StatefulWidget {
  final String capTren;
  const DanhSachLopSheet({super.key, required this.capTren});

  @override
  State<DanhSachLopSheet> createState() => _DanhSachLopSheetState();
}

class _DanhSachLopSheetState extends State<DanhSachLopSheet> {
  final List<int> selectedLopIds = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: BlocBuilder<LopBloc, LopDetailState>(
        builder: (context, state) {
          if (state is LopDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AllLopLoaded) {
            final prefs = SharedPreferences.getInstance();
            return FutureBuilder(
              future: prefs,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox.shrink();
                final userId = snapshot.data?.getInt('user_id');
                print('============${widget.capTren}');
                final list =
                    (widget.capTren == 'khoa' || widget.capTren == 'phong_ctct')
                    ? state.danhSachLop
                    : state.danhSachLop
                          .where((lop) => lop.giangVien.id == userId)
                          .toList();

                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Chọn lớp gửi thông báo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 12),
                    // Thêm nút chọn tất cả
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if (selectedLopIds.length == list.length) {
                              // Đã chọn hết, bấm để bỏ chọn hết
                              selectedLopIds.clear();
                            } else {
                              // Chưa chọn hết, bấm để chọn tất cả
                              selectedLopIds
                                ..clear()
                                ..addAll(list.map((lop) => lop.id));
                            }
                          });
                        },
                        child: Text(
                          selectedLopIds.length == list.length
                              ? 'Bỏ chọn tất cả'
                              : 'Chọn tất cả các lớp',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: list.length,
                          itemBuilder: (_, index) {
                            final lop = list[index];
                            final isSelected = selectedLopIds.contains(lop.id);
                            return CheckboxListTile(
                              title: Text(lop.tenLop),
                              subtitle: Text('Mã lớp: ${lop.id}'),
                              value: isSelected,
                              onChanged: (bool? selected) {
                                setState(() {
                                  if (selected == true) {
                                    selectedLopIds.add(lop.id);
                                  } else {
                                    selectedLopIds.remove(lop.id);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Nút gửi
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(Icons.send, color: Colors.white),
                        label: const Text(
                          'Gửi thông báo',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pop(context, selectedLopIds);
                        },
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                );
              },
            );
          }

          if (state is LopDetailError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: Text('Không có lớp nào.'));
        },
      ),
    );
  }
}
