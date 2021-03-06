#!/bin/sh

# demo-relay-ux.sh -- test/demo for ccn-lite: CCNx relaying via UNIX sockets

CCNL_HOME=../..

UXA=/tmp/ccn-lite-relay-$$-a.sock
UXB=/tmp/ccn-lite-relay-$$-b.sock

# topology:

#  ccn-lite-peek --> relay A     -->  relay B
#
#                 /tmp/a.sock      /tmp/b.sock (unix sockets: ctrl and data)

# ----------------------------------------------------------------------

echo -n "killing all ccn-lite-relay instances... "
killall ccn-lite-relay

echo
# starting relay A, with a link to relay B
$CCNL_HOME/ccn-lite-relay -v 99 -x $UXA 2>/tmp/a.log &
sleep 1
FACEID=`$CCNL_HOME/util/ccn-lite-ctrl -x $UXA newUNIXface $UXB | $CCNL_HOME/util/ccn-lite-ccnb2xml | grep FACEID | sed -e 's/.*\([0-9][0-9]*\).*/\1/'`
$CCNL_HOME/util/ccn-lite-ctrl -x $UXA prefixreg /ccnx/0.7.1/doc/technical $FACEID | $CCNL_HOME/util/ccn-lite-ccnb2xml | grep ACTION


# starting relay B, with content loading
$CCNL_HOME/ccn-lite-relay -v 99 -x $UXB -d $CCNL_HOME/test/ccnb 2>/tmp/b.log &
sleep 1

# test case: ask relay A to deliver content that is hosted at relay B
$CCNL_HOME/util/ccn-lite-peek -x $UXA /ccnx/0.7.1/doc/technical/NameEnumerationProtocol.txt | $CCNL_HOME/util/ccn-lite-ccnb2hex

# shutdown both relays
echo ""
echo "# Config of relay A:"
$CCNL_HOME/util/ccn-lite-ctrl -x $UXA debug dump+halt | $CCNL_HOME/util/ccn-lite-ccnb2xml
echo ""
echo "# Config of relay B:"
$CCNL_HOME/util/ccn-lite-ctrl -x $UXB debug dump+halt | $CCNL_HOME/util/ccn-lite-ccnb2xml

# eof
