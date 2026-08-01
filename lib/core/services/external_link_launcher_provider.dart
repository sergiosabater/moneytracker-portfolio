import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:moneytracker/core/services/external_link_launcher.dart';

part 'external_link_launcher_provider.g.dart';

@Riverpod(keepAlive: true)
ExternalLinkLauncher externalLinkLauncher(Ref ref) => ExternalLinkLauncher();