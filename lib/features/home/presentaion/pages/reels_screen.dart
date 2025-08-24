import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/services/native_video_service.dart';
import '../../../../core/services/locator_service.dart' as di;
import '../../../../core/routes/route_names.dart';
import '../manager/reel_cubit.dart';
import '../manager/reel_state.dart';
import '../../data/models/reel_model.dart';

class ReelsScreen extends StatefulWidget {
  final int? initialReelId;
  
  const ReelsScreen({
    super.key,
    this.initialReelId,
  });

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _pageController = PageController();
  
  int _currentIndex = 0;
  bool _isLoading = false;
  String? _errorMessage;
  
  @override
  void initState() {
    super.initState();
  }
  
  void _jumpToReelById(int reelId, List<ReelModel> reels) {
    final reelIndex = reels.indexWhere((reel) => reel.id == reelId);
    if (reelIndex != -1) {
      _currentIndex = reelIndex;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pageController.hasClients) {
          _pageController.jumpToPage(_currentIndex);
        }
      });
    }
  }
  
  void _playNextReel() {
    final reels = context.read<ReelCubit>().state.reels;
    if (_currentIndex < reels.length - 1) {
      _currentIndex++;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  
  void _playPreviousReel() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  
  void _onReelChanged(int index) {
    print('🔄 ReelsScreen: Reel changed from $_currentIndex to $index');
    
    setState(() {
      _currentIndex = index;
      _isLoading = false;
      _errorMessage = null;
    });
  }
  
  Future<bool> _onWillPop() async {
    print('🔄 ReelsScreen: WillPopScope triggered - cleaning up resources');
    // إيقاف جميع الفيديوهات قبل العودة
    NativeVideoService.dispose();
    return true;
  }
  
  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);
      
      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Recently';
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReelCubit>(
      create: (context) => di.sl<ReelCubit>()..loadReels(),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: BlocBuilder<ReelCubit, ReelState>(
            builder: (context, state) {
              // Jump to specific reel if initialReelId is provided and data is loaded
              if (widget.initialReelId != null && state.reels.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _jumpToReelById(widget.initialReelId!, state.reels);
                });
              }
              
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              
              if (state.error != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 64.sp,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Error: ${state.error}',
                        style: AppTextStyles.secondaryS14W400.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: () {
                          context.read<ReelCubit>().loadReels();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              
              if (state.reels.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.video_library_outlined,
                        color: Colors.white,
                        size: 64.sp,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No reels available',
                        style: AppTextStyles.blackS18W700.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Check back later for new reels',
                        style: AppTextStyles.secondaryS14W400.copyWith(color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              
              return Stack(
                children: [
                  // Video PageView
                  PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    onPageChanged: _onReelChanged,
                    itemCount: state.reels.length,
                    itemBuilder: (context, index) {
                      final reel = state.reels[index];
                      return _buildReelItem(reel, index);
                    },
                  ),
                  
                  // Top Bar - "Reels" text only
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 16.h,
                        left: 16.w,
                        right: 16.w,
                        bottom: 16.h,
                      ),
                      child: Row(
                        children: [
                                                                                IconButton(
                              onPressed: () {
                                print('🔙 ReelsScreen: Back button pressed');
                                // إيقاف الفيديو قبل العودة
                                NativeVideoService.dispose();
                                _onWillPop().then((_) {
                                  if (context.canPop()) {
                                    context.pop();
                                  } else {
                                    context.go(RouteNames.homeScreen);
                                  }
                                });
                              },
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                            ),
                          const Spacer(),
                          Text(
                            'Reels',
                            style: AppTextStyles.blackS18W700.copyWith(color: Colors.white),
                          ),
                          const Spacer(),
                          SizedBox(width: 48.w), // Balance the back button
                        ],
                      ),
                    ),
                  ),
                  
                                     // Right Side Interaction Overlay - Simplified
                   if (_currentIndex < state.reels.length)
                     Positioned(
                       right: 16.w,
                       bottom: 200.h,
                       child: Column(
                         children: [
                           _buildInteractionButton(
                             icon: Icons.favorite,
                             label: '${state.reels[_currentIndex].likesCount}',
                             onTap: () {
                               
                             },
                           ),
                           SizedBox(height: 20.h),
                           _buildInteractionButton(
                             icon: Icons.visibility,
                             label: '${state.reels[_currentIndex].viewsCount}',
                             onTap: () {},
                           ),
                         ],
                       ),
                     ),
                  
                  // Bottom Information Overlay
                  if (_currentIndex < state.reels.length)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          bottom: MediaQuery.of(context).padding.bottom + 16.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profile Information - Clickable
                                                         GestureDetector(
                                                              onTap: () {
                                  print('👤 ReelsScreen: Navigating to dealer profile for ${state.reels[_currentIndex].dealerUsername ?? '@cardealer_uae'}');
                                  // إيقاف الفيديو قبل الانتقال
                                  NativeVideoService.dispose();
                                  // Navigate to dealer profile with dealer ID
                                  final dealerId = state.reels[_currentIndex].dealer;
                                  context.go('${RouteNames.dealerProfileWithId.replaceAll(':id', dealerId.toString())}');
                                },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor: Colors.grey[600],
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    state.reels[_currentIndex].dealerUsername ?? '@cardealer_uae',
                                    style: AppTextStyles.blackS16W600.copyWith(color: Colors.white),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white70,
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            
                                                         // Video Caption
                             Text(
                               state.reels[_currentIndex].description.isNotEmpty 
                                   ? state.reels[_currentIndex].description
                                   : 'Check out this amazing car! 🔥',
                               style: AppTextStyles.secondaryS14W400.copyWith(color: Colors.white),
                               maxLines: 3,
                               overflow: TextOverflow.ellipsis,
                             ),
                             SizedBox(height: 12.h),
                             
                             // Dealer Info
                             Row(
                               children: [
                                 Icon(
                                   Icons.business,
                                   color: Colors.white70,
                                   size: 16.sp,
                                 ),
                                 SizedBox(width: 8.w),
                                 Text(
                                   state.reels[_currentIndex].dealerName ?? 'Car Dealer',
                                   style: AppTextStyles.secondaryS12W400.copyWith(color: Colors.white70),
                                 ),
                                 SizedBox(width: 20.w),
                                 Icon(
                                   Icons.calendar_today,
                                   color: Colors.white70,
                                   size: 16.sp,
                                 ),
                                 SizedBox(width: 8.w),
                                 Text(
                                   _formatDate(state.reels[_currentIndex].createdAt),
                                   style: AppTextStyles.secondaryS12W400.copyWith(color: Colors.white70),
                                 ),
                               ],
                             ),
                          ],
                        ),
                      ),
                    ),
                  
                  
                  
                  // Loading Indicator
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  
                  // Error Message
                  if (_errorMessage != null)
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        margin: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          _errorMessage!,
                          style: AppTextStyles.secondaryS14W400.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
  
  Widget _buildReelItem(ReelModel reel, int index) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Stack(
        children: [
          // Video Player
          if (index == _currentIndex)
            NativeVideoWidget(
              key: ValueKey('reel_${reel.id}_${index}'), // Unique key for each video
              videoUrl: reel.video,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              muted: false, // تشغيل الصوت في شاشة الـ reels
              loop: true, // إعادة تشغيل الفيديو تلقائياً
              onVideoReady: () {
                print('✅ ReelsScreen: Video ready for reel ${reel.id} at index $index');
                setState(() {
                  _isLoading = false;
                });
              },
              onVideoError: () {
                print('❌ ReelsScreen: Video error for reel ${reel.id} at index $index');
                setState(() {
                  _errorMessage = 'Failed to load video';
                  _isLoading = false;
                });
              },
            )
          else
            // Thumbnail for non-active reels
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[900],
              ),
              child: reel.thumbnail.isNotEmpty
                  ? Image.network(
                      reel.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.video_library,
                            color: Colors.white54,
                            size: 48,
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Icon(
                        Icons.video_library,
                        color: Colors.white54,
                        size: 48,
                      ),
                    ),
            ),
          
          // Play Button for non-active reels
          if (index != _currentIndex)
            Center(
              child: Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildInteractionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: AppTextStyles.secondaryS12W400.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    print('🗑️ ReelsScreen: Disposing page controller and cleaning up resources');
    _pageController.dispose();
    NativeVideoService.dispose();
    super.dispose();
  }
}
