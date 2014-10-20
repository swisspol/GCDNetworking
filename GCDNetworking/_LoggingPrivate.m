/*
 Copyright (c) 2012-2014, Pierre-Olivier Latour
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 * The name of Pierre-Olivier Latour may not be used to endorse
 or promote products derived from this software without specific
 prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL PIERRE-OLIVIER LATOUR BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "_LoggingPrivate.h"

#if defined(__LOGGING_FACILITY_BUILTIN__)
#if DEBUG
int _LoggingMinLevel = _LOG_LEVEL_DEBUG;
#else
int _LoggingMinLevel = _LOG_LEVEL_INFO;
#endif
#elif defined(__LOGGING_FACILITY_COCOALUMBERJACK__)
#if DEBUG
int _LoggingMinLevel = LOG_LEVEL_DEBUG;
#else
int _LoggingMinLevel = LOG_LEVEL_INFO;
#endif
#endif

#ifdef __LOGGING_FACILITY_BUILTIN__

void _LogMessage(int level, NSString* format, ...) {
  static const char* levelNames[] = {"DEBUG", "VERBOSE", "INFO", "WARNING", "ERROR", "EXCEPTION"};
  static int enableLogging = -1;
  if (enableLogging < 0) {
    enableLogging = (isatty(STDERR_FILENO) ? 1 : 0);
  }
  if (enableLogging) {
    va_list arguments;
    va_start(arguments, format);
    NSString* message = [[NSString alloc] initWithFormat:format arguments:arguments];
    va_end(arguments);
    fprintf(stderr, "[%s] %s\n", levelNames[level], [message UTF8String]);
  }
}

#endif
