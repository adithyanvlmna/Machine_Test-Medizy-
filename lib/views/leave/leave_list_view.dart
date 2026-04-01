import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';
import '../../viewmodels/leave_viewmodel.dart';

class LeaveListView extends StatefulWidget {
  const LeaveListView({super.key});

  @override
  State<LeaveListView> createState() => _LeaveListViewState();
}

class _LeaveListViewState extends State<LeaveListView> {
  int _selectedTab = 0; // 0: All, 1: Pending, 2: Approved, 3: Reject

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LeaveViewModel>().fetchLeaveList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LeaveViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: AppColors.primaryLight,
              child: Icon(Icons.person, color: Colors.white),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Leave List',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              // Tabs
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    _buildTabItem(0, "All"),
                    _buildTabItem(1, "Pending"),
                    _buildTabItem(2, "Approved"),
                    _buildTabItem(3, "Reject"),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Filters Row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primaryDark),
                    ),
                    child: const Row(
                      children: [
                        Text("January", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 4),
                        Icon(Icons.keyboard_arrow_down, size: 20),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primaryDark),
                    ),
                    child: const Text("Your Leave 01", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: vm.isLoading 
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: vm.leaveList.length,
                      itemBuilder: (context, index) {
                        return _buildLeaveCard(vm.leaveList[index]);
                      },
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(int index, String title) {
    bool isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryDark : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveCard(dynamic leave) {
    Color statusColor;
    if (leave['status'] == 'Approved') statusColor = Colors.green;
    else if (leave['status'] == 'Pending') statusColor = Colors.orange;
    else statusColor = Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(12),
         border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(
                 leave['desc'] ?? '',
                 style: const TextStyle(color: Colors.grey, fontSize: 13),
               ),
               if (leave['status'] == 'Pending')
                 const Icon(Icons.delete_outline, size: 20, color: Colors.grey),
             ],
           ),
           const SizedBox(height: 4),
           Text(
             leave['date'] ?? '',
             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
           ),
           const SizedBox(height: 4),
           Text(
             leave['type'] ?? '',
             style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13),
           ),
           const SizedBox(height: 16),
           // Timeline Status Indicator
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               _buildStatusStep("Create", true, Colors.green),
               _buildDash(),
               _buildStatusStep("Review", true, Colors.green),
               _buildDash(),
               _buildStatusStep(leave['status'], true, statusColor),
             ],
           )
        ],
      ),
    );
  }

  Widget _buildStatusStep(String title, bool isCompleted, Color color) {
    return Row(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: color,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        )
      ],
    );
  }

  Widget _buildDash() {
    return Container(
      width: 20,
      height: 2,
      color: Colors.grey.shade300,
    );
  }
}
