import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../../data/models/models.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({Key? key}) : super(key: key);

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    context.read<AppStateProvider>().sendMessage(_controller.text.trim());
    _controller.clear();
    
    // Scroll to bottom after message sent
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Career Assistant"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(LucideIcons.rotateCcw, size: 20)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<AppStateProvider>(
              builder: (context, state, _) {
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(20),
                  itemCount: state.chatMessages.length,
                  itemBuilder: (context, index) {
                    final msg = state.chatMessages[index];
                    return _buildChatBubble(msg);
                  },
                );
              },
            ),
          ),
          _buildQuickPrompts(),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: msg.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!msg.isUser)
            const CircleAvatar(
              backgroundColor: AppColors.primaryBlue,
              radius: 16,
              child: Icon(LucideIcons.bot, size: 16, color: Colors.white),
            ),
          if (!msg.isUser) const SizedBox(width: 12),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: msg.isUser ? AppColors.primaryBlue : AppColors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(msg.isUser ? 16 : 0),
                  bottomRight: Radius.circular(msg.isUser ? 0 : 16),
                ),
              ),
              child: Text(
                msg.text,
                style: TextStyle(color: msg.isUser ? Colors.white : AppColors.textPrimary, fontSize: 15),
              ),
            ),
          ),
          if (msg.isUser) const SizedBox(width: 12),
          if (msg.isUser)
            const CircleAvatar(
              backgroundColor: AppColors.primaryPurple,
              radius: 16,
              child: Icon(LucideIcons.user, size: 16, color: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget _buildQuickPrompts() {
    final prompts = ["What are my top careers?", "Analyze my skill gap", "Suggest a roadmap"];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: prompts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.read<AppStateProvider>().sendMessage(prompts[index]);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
              ),
              child: Center(
                child: Text(prompts[index], style: const TextStyle(color: AppColors.primaryBlue, fontSize: 12)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Ask anything about your career...",
                  hintStyle: TextStyle(color: AppColors.textMuted),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
