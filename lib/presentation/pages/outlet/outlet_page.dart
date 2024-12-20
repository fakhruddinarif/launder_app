import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launder_app/models/outlet.dart';
import 'package:launder_app/presentation/blocs/outlet/outlet_bloc.dart';
import 'package:launder_app/presentation/blocs/outlet/outlet_state.dart';
import 'package:launder_app/presentation/pages/outlet/detail_outlet_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../blocs/outlet/outlet_event.dart';

class OutletPage extends StatefulWidget {
  const OutletPage({Key? key}) : super(key: key);

  @override
  _OutletPageState createState() => _OutletPageState();
}

class _OutletPageState extends State<OutletPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<OutletBloc>().add(OutletListEvent(page: _currentPage, size: _pageSize));
  }

  Future<void> _refresh() async {
    _currentPage = 1;
    context.read<OutletBloc>().add(OutletListEvent(page: _currentPage, size: _pageSize));
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _currentPage++;
      context.read<OutletBloc>().add(OutletListEvent(page: _currentPage, size: _pageSize));
    } else if (_scrollController.position.pixels == _scrollController.position.minScrollExtent) {
      _refresh();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outlet', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: Container(
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: BlocConsumer<OutletBloc, OutletState>(
                  builder: (context, state) {
                    if (state is OutletLoading && _currentPage == 1) {
                      return Skeletonizer(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total 10 Outlet', style: const TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w500),),
                              const SizedBox(height: 16,),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 6,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        leading: const Icon(Icons.store, color: Colors.black54, size: 32,),
                                        title: Container(
                                          width: 100,
                                          height: 16,
                                          color: Colors.grey.withOpacity(0.1),
                                        ),
                                        subtitle: Container(
                                          width: 200,
                                          height: 16,
                                          color: Colors.grey.withOpacity(0.1),
                                        ),
                                        trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54, size: 16,),
                                      ),
                                    );
                                  }
                              ),
                            ],
                          )
                      );
                    }
                    if (state is OutletListSuccess) {
                      final outlets = state.data;
                      return _listOutlets(context, outlets);
                    }
                    return Center(child: Image.asset("assets/images/no_load_data.png"),);
                  },
                  listener: (context, state) {
                    if (state is OutletFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red,));
                    }
                  }
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/outlet/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _listOutlets(BuildContext context, ListOutlet outlets) {
    if (outlets.totalItem == 0) {
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/outlet_blank.png'),
              const SizedBox(height: 8),
              Text('No outlets registered.', style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),),
            ],
          )
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Total ${outlets.totalItem} Outlet', style: const TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w500),),
        const SizedBox(height: 16,),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: outlets.totalItem > outlets.size ? outlets.size : outlets.totalItem,
            itemBuilder: (context, index) {
              return _cardOutlet(context, outlets.data[index]);
            }
        ),
      ],
    );
  }

  Widget _cardOutlet(BuildContext context, Outlet outlet) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailOutletPage()));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ListTile(
          leading: outlet.logo != null ? Image.network(outlet.logo!) : const Icon(Icons.store, color: Colors.black54, size: 32,),
          title: Text(outlet.name, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
          subtitle: Text("${outlet.address} - ${outlet.city}", style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w400),),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54, size: 16,),
        ),
      ),
    );
  }
}