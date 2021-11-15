class Notice {
  Notice(
      {this.title,
      this.date,
      this.writer,
      this.contents,
      this.docId,
      this.commentCount,
      this.likedUsers,
      this.likeCount}); //constructor
  var title;
  var date;
  var writer;
  var contents;
  var docId;
  var likeCount;
  var commentCount;
  dynamic likedUsers;
}
