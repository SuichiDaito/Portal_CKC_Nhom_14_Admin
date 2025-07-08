import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/phong_bloc.dart';
import 'package:portal_ckc/bloc/event/phong_event.dart';
import 'package:portal_ckc/bloc/state/phong_state.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/card/list_room_add_edit_room_bottom_sheet.dart';
import 'package:portal_ckc/presentation/sections/card/room_list_item.dart';
import '../../api/model/admin_phong.dart';

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
            final bloc = context.read<PhongBloc>();
            if (room == null) {
              bloc.add(CreateRoomEvent(savedRoom));
            } else {
              bloc.add(UpdateRoomEvent(id: room.id!, room: savedRoom));
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhongBloc, PhongState>(
      listener: (context, state) {
        if (state is PhongSuccess) {
          context.read<PhongBloc>().add(FetchRoomsEvent());
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is PhongError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('❌ ${state.message}')));
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
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
              child: Card(
                color: Colors.blue,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lọc theo loại phòng',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<int>(
                        value: selectedRoomType,
                        isExpanded: true,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.blue,
                        ),
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blueAccent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blueAccent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                        dropdownColor: Colors.white,
                        items: const [
                          DropdownMenuItem(
                            value: null,
                            child: Text(
                              'Tất cả loại phòng',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              'Phòng học lý thuyết',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text(
                              'Phòng thực hành',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text(
                              'Phòng họp',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedRoomType = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
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
                          onTap: () => _showAddEditRoomSheet(room: room),
                          child: RoomListItem(index: index, room: room),
                        );
                      },
                    );
                  } else if (state is PhongError) {
                    return Center(
                      child: Text(
                        'Không thể truy cập chức năng này, vui lòng thử lại sau',
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
