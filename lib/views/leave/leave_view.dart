import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';
import '../../viewmodels/leave_viewmodel.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import 'leave_list_view.dart';

class LeaveView extends StatefulWidget {
  const LeaveView({super.key});

  @override
  State<LeaveView> createState() => _LeaveViewState();
}

class _LeaveViewState extends State<LeaveView> {
  bool isFullDay = true;
  String _leaveType = 'Casual';
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  final _reasonController = TextEditingController();
  
  void _onApply() async {
    final vm = context.read<LeaveViewModel>();
    final success = await vm.applyLeave({
      "leave_mode": isFullDay ? "full_day" : "half_day",
      "leave_type": _leaveType,
      "start_date": _fromDateController.text,
      "end_date": _toDateController.text,
      "reason": _reasonController.text,
    });
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Leave Applied Successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<LeaveViewModel>().isLoading;

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Apply Leave',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              // Toggle
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isFullDay = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: isFullDay ? AppColors.primaryDark : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Full Day',
                            style: TextStyle(
                              color: isFullDay ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isFullDay = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: !isFullDay ? AppColors.primaryDark : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Half Day',
                            style: TextStyle(
                              color: !isFullDay ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(16),
                   border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      labelText: 'From',
                      hintText: 'DD/MM/YYYY',
                      suffixIcon: const Icon(Icons.calendar_month),
                      controller: _fromDateController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'To',
                      hintText: 'DD/MM/YYYY',
                      suffixIcon: const Icon(Icons.calendar_month),
                      controller: _toDateController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Reason',
                      hintText: 'Enter Leave reason',
                      maxLines: 3,
                      controller: _reasonController,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Leave Type',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _leaveType,
                              hint: const Text('Select your Leave type'),
                              items: const [
                                DropdownMenuItem(value: 'Casual', child: Text('Casual Leave')),
                                DropdownMenuItem(value: 'Sick', child: Text('Sick Leave')),
                              ],
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _leaveType = val);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                PrimaryButton(
                  text: 'Apply',
                  onPressed: _onApply,
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  text: 'Leave List',
                  isOutline: true,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LeaveListView()),
                    );
                  },
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
