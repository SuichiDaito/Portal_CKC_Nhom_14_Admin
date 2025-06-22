import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/exam_scheldule_filter_buttons_row.dart';
import 'package:portal_ckc/presentation/sections/card/list_room_add_edit_room_bottom_sheet.dart';
import 'package:portal_ckc/presentation/sections/card/room_list_item.dart';
import 'package:portal_ckc/presentation/sections/card/room_status.dart';

class PageRoomManagement extends StatefulWidget {
  const PageRoomManagement({Key? key}) : super(key: key);

  @override
  _PageRoomManagementState createState() => _PageRoomManagementState();
}

class _PageRoomManagementState extends State<PageRoomManagement> {
  // Dữ liệu giả (thay thế bằng dữ liệu thực tế từ API sau này)
  final List<Room> _rooms = [
    Room(
      id: 'R001',
      name: 'Phòng A101',
      capacity: 50,
      type: RoomType.lectureHall,
      status: RoomStatus.available,
    ),
    Room(
      id: 'R002',
      name: 'Phòng LAB203',
      capacity: 30,
      type: RoomType.laboratory,
      status: RoomStatus.inUse,
    ),
    Room(
      id: 'R003',
      name: 'Phòng B205',
      capacity: 40,
      type: RoomType.lectureHall,
      status: RoomStatus.maintenance,
    ),
    Room(
      id: 'R004',
      name: 'Phòng họp 1',
      capacity: 15,
      type: RoomType.meetingRoom,
      status: RoomStatus.available,
    ),
  ];
  RoomStatus? selectedRoomStatus;
  List<Room> get filteredRooms {
    if (selectedRoomStatus == null) {
      return _rooms;
    }
    return _rooms.where((room) => room.status == selectedRoomStatus).toList();
  }

  void _addRoom(Room newRoom) {
    setState(() {
      _rooms.add(newRoom);
      _rooms.sort(
        (a, b) => a.name.compareTo(b.name),
      ); // Sắp xếp theo tên cho dễ nhìn
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã thêm phòng ${newRoom.name} thành công!')),
    );
  }

  void _updateRoom(Room updatedRoom) {
    setState(() {
      final index = _rooms.indexWhere((room) => room.id == updatedRoom.id);
      if (index != -1) {
        _rooms[index] = updatedRoom;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã cập nhật phòng ${updatedRoom.name} thành công!'),
      ),
    );
  }

  void _showAddEditRoomSheet({Room? room}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Cho phép bottom sheet cuộn khi bàn phím hiện lên
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return AddEditRoomBottomSheet(
          roomToEdit: room,
          onSave: (savedRoom) {
            if (room == null) {
              _addRoom(savedRoom);
            } else {
              _updateRoom(savedRoom);
            }
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
          SizedBox(height: 20),
          RoomStatusFilter(
            currentFilter: selectedRoomStatus,
            onFilterChanged: (RoomStatus? status) {
              setState(() {
                selectedRoomStatus = status;
              });
            },
          ),
          SizedBox(height: 15),

          Expanded(
            child: _rooms.isEmpty
                ? const Center(
                    child: Text(
                      'Chưa có phòng nào được thêm.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _rooms.length,
                    itemBuilder: (context, index) {
                      final room = _rooms[index];
                      return GestureDetector(
                        onLongPress: () => _showAddEditRoomSheet(
                          room: room,
                        ), // Nhấn giữ để sửa
                        child: RoomListItem(
                          index: index,
                          room: room,
                          onUpdateStatus: (updatedRoom) {
                            _updateRoom(updatedRoom);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
