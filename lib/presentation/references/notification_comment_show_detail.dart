

// References when show comment;

// Widget _buildCommentList() {
  //   if (_comments.isEmpty) {
  //     return Padding(
  //       padding: const EdgeInsets.all(20),
  //       child: Center(
  //         child: Column(
  //           children: [
  //             Icon(
  //               Icons.chat_bubble_outline,
  //               size: 48,
  //               color: Colors.grey[400],
  //             ),
  //             const SizedBox(height: 12),
  //             Text(
  //               'Chưa có bình luận nào',
  //               style: TextStyle(color: Colors.grey[600], fontSize: 16),
  //             ),
  //             const SizedBox(height: 4),
  //             Text(
  //               'Hãy là người đầu tiên bình luận',
  //               style: TextStyle(color: Colors.grey[500], fontSize: 14),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }

  //   return ListView.separated(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
  //     itemCount: _comments.length,
  //     separatorBuilder: (context, index) => const SizedBox(height: 16),
  //     itemBuilder: (context, index) {
  //       final comment = _comments[index];
  //       return _buildCommentItem(comment);
  //     },
  //   );
  // }