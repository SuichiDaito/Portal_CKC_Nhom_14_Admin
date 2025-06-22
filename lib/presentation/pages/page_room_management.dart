import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/phong_bloc.dart';
import 'package:portal_ckc/bloc/event/phong_event.dart';
import 'package:portal_ckc/bloc/state/phong_state.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/card/list_room_add_edit_room_bottom_sheet.dart';
import 'package:portal_ckc/presentation/sections/card/room_list_item.dart';
import '../../api/model/admin_phong.dart'; // ✅ model Room gốc từ API

class PageRoomManagement extends StatefulWidget {
  const PageRoomManagement({Key? key}) : super(key: key);

  @override
  _PageRoomManagementState createState() => _PageRoomManagementState();
}

class _PageRoomManagementState extends State<PageRoomManagement> {
  int? selectedRoomType;

  @override
  void initState() {
    super.initState();
    context.read<PhongBloc>().add(FetchRoomsEvent());
  }

  void _showAddEditRoomSheet({Room? room}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return AddEditRoomBottomSheet(
          roomToEdit: room,
          onSave: (savedRoom) {
            context.read<PhongBloc>().add(FetchRoomsEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  room == null
                      ? 'Đã thêm phòng ${savedRoom.ten}!'
                      : 'Đã cập nhật phòng ${savedRoom.ten}!',
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBarTitle(title: 'Quản lý phòng học'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEditRoomSheet(),
        label: const Text('Thêm phòng'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                labelText: 'Lọc theo loại phòng',
                border: OutlineInputBorder(),
              ),
              value: selectedRoomType,
              items: const [
                DropdownMenuItem(value: 1, child: Text('Phòng học lý thuyết')),
                DropdownMenuItem(value: 2, child: Text('Phòng thực hành')),
                DropdownMenuItem(value: 3, child: Text('Phòng họp')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedRoomType = value;
                });
              },
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: BlocBuilder<PhongBloc, PhongState>(
              builder: (context, state) {
                if (state is PhongLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PhongLoaded) {
                  final filteredRooms = selectedRoomType == null
                      ? state.rooms
                      : state.rooms
                            .where((r) => r.loaiPhong == selectedRoomType)
                            .toList();

                  if (filteredRooms.isEmpty) {
                    return const Center(child: Text('Không có phòng nào.'));
                  }

                  return ListView.builder(
                    itemCount: filteredRooms.length,
                    itemBuilder: (context, index) {
                      final room = filteredRooms[index];
                      return GestureDetector(
                        onLongPress: () => _showAddEditRoomSheet(room: room),
                        child: RoomListItem(index: index, room: room),
                      );
                    },
                  );
                } else if (state is PhongError) {
                  return Center(child: Text('Lỗi: ${state.message}'));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
