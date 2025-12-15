import 'dart:async';

import 'package:flutter/material.dart';

class InfoCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final ValueChanged<String>? onChanged;
  final String? Function(String value)? validator;

  final bool editable;

  final int debounceMilliseconds;

  const InfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.onChanged,
    this.validator,
    this.editable = true,
    this.debounceMilliseconds = 400,
  });

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isEditing = false;
  String? _error;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant InfoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && !_isEditing) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startEditing() {
    if (!widget.editable || widget.onChanged == null) return;

    setState(() {
      _isEditing = true;
      _error = null;
    });

    // Forzar focus y teclado
    Future.microtask(() {
      if (mounted) {
        _focusNode.requestFocus();
        _controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controller.text.length,
        );
      }
    });
  }


  void _commitEditing() {
    final value = _controller.text;
    // validación final
    if (widget.validator != null) {
      final res = widget.validator!(value);
      setState(() => _error = res);
      if (res != null) {
        _focusNode.requestFocus();
        return;
      }
    } else {
      setState(() => _error = null);
    }

    _debounce?.cancel();
    if (widget.debounceMilliseconds <= 0) {
      widget.onChanged?.call(value);
    } else {
      widget.onChanged?.call(value);
    }

    _focusNode.unfocus();
    setState(() => _isEditing = false);
  }

  void _onChangedLocal(String value) {
    if (widget.validator != null) {
      final result = widget.validator!(value);
      setState(() => _error = result);
      if (result != null) {
        return;
      }
    } else {
      setState(() => _error = null);
    }
    _debounce?.cancel();
    if (widget.debounceMilliseconds <= 0) {
      widget.onChanged?.call(value);
    } else {
      _debounce = Timer(Duration(milliseconds: widget.debounceMilliseconds), () {
        widget.onChanged?.call(value);
      });
    }
  }
  Widget _buildInlineField() {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      enabled: true,
      readOnly: !_isEditing,
      maxLines: 2,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        hintText: widget.label,
        hintStyle: TextStyle(color: widget.color.withValues(alpha: 0.5)),
        errorText: _error,
      ),
      onChanged: _isEditing ? _onChangedLocal : null,
      onSubmitted: (_) => _commitEditing(),
      textInputAction: TextInputAction.done,
      onTap: () {
        if (!_isEditing && widget.editable && widget.onChanged != null) {
          _startEditing();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.color.withValues(alpha: 0.1),
            Colors.grey.shade900.withValues(alpha: 0.3),
          ],
        ),
        border: Border.all(
          color: widget.color.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.color.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            if (widget.onChanged != null && widget.editable) {
              _startEditing();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.color.withValues(alpha: 0.3),
                        widget.color.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: widget.color.withValues(alpha: 0.5),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.color.withValues(alpha: 0.3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.color,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label.toUpperCase(),
                        style: TextStyle(
                          color: widget.color.withValues(alpha: 0.8),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _buildInlineField(),
                      if (_error != null && !_isEditing)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            _error!,
                            style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),

                InkWell(
                  onTap: () {
                    if (_isEditing) {
                      _commitEditing();
                    } else {
                      if (widget.editable && widget.onChanged != null) {
                        _startEditing();
                      }
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      _isEditing ? Icons.check : Icons.edit,
                      color: widget.color.withValues(alpha: 0.3),
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
